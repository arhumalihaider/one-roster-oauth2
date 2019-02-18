require 'oauth2'
require 'flexirest'
require 'addressable'
require 'byebug'

module Oneroster
  class ApiBase < Flexirest::Base
    cattr_accessor :consumer_key, :consumer_secret, :vendor_key, :vendor_secret

    # this are changable from the UI just like the base_url
    VENDOR_KEY = "naiku_B2F50DD0"
    VENDOR_SECRET = "5428E07353E6D58F849CCE4145BDA703"

    def self.api_auth_credentials(key, secret, vendor_key = VENDOR_KEY, vendor_secret = VENDOR_SECRET)
      self.consumer_key = key
      raise "No key" if key.blank?
      self.consumer_secret = secret
      raise "No secret" if secret.blank?
      if (vendor_key.blank? && !vendor_key.nil?) || (vendor_secret.blank? && !vendor_secret.nil?)
        raise "Both vendor_key and vendor_secret are required only for Grading Services endpoints"
      end
      self.vendor_key = vendor_key
      self.vendor_secret = vendor_secret
    end


    BASE_URL = 'https://oneroster.infinitecampus.org/campus/oneroster/entropyMaster/ims/oneroster/v1p1/'
    base_url BASE_URL
    def self.inherited(klass)
      super(klass)
      klass.verbose!
      klass.request_body_type :json
    end
    before_request :set_authorization

    def set_authorization(name, request)
      consumer = OAuth::Consumer.new( self.class.consumer_key, self.class.consumer_secret, {
        :site => self.class.base_url,
        :signature_method => "HMAC-SHA256",
        :scheme => 'header'
      })

      timestamp = Time.now.to_i
      nonce = SecureRandom.uuid

      if request.method[:method] == :put || request.method[:method] == :post
        options = {:timestamp => timestamp,:nonce => nonce, :oauth_callback => 'about:blank'}
      else
        options = {:timestamp => timestamp,:nonce => nonce}
      end

      url = Addressable::URI.parse(request.url)
      if request.get_params.any?
        url.query_values = (url.query_values || {}).merge request.get_params
      end
      url = url.normalize.to_s

      # create signed request
      req = consumer.create_signed_request(request.method[:method], url, nil, options)

      if request.method[:method] == :put || request.method[:method] == :post
        # get oauth body hash part to change the hash
        oauth_body_hash_el = req['Authorization'].split(', ').find{|a| a.match /oauth_body_hash/}
        # get the hash
        oauth_body_hash = oauth_body_hash_el.split('"')
        # remove hash
        oauth_body_hash.pop
        # get post params
        body = request.post_params.to_json
        # create a new hash and encrypt
        new_oauth_body_hash = Base64.encode64(OpenSSL::Digest::SHA256.digest(body || '')).chomp.gsub(/\n/,'')
        # add new hash back to the arrat
        oauth_body_hash.push CGI::escape(new_oauth_body_hash)
        # replace the old one with the new one
        auth = req['Authorization'].gsub(req['Authorization'].split(', ').find{|a| a.match /oauth_body_hash/}, oauth_body_hash.join('"')+"\"")
        request.headers['Authorization'] = auth
      else
        request.headers['Authorization'] = req['Authorization']
      end
      # unless self.class.vendor_key.blank? && self.class.vendor_secret.blank?
      #   request.headers['x-vendor-authorization'] = "#{self.class.vendor_key}%3A#{self.class.vendor_secret}"
      # end
    end
  end
end
