require 'oauth'
require 'flexirest'
require 'addressable'

module Oneroster
  class ApiBase < Flexirest::Base
    cattr_accessor :consumer_key, :consumer_secret, :vendor_key, :vendor_secret

    def self.api_auth_credentials(key, secret, vendor_key = nil, vendor_secret = nil)
      self.consumer_key = key
      raise "No key" if key.blank?
      self.consumer_secret = secret
      raise "No secret" if secret.blank?
      raise "Both vendor key and secret are needed" if ((vendor_key.blank? && !vendor_key.blank?) || (!vendor_key.blank? && vendor_key.blank?))
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
        :signature_method => "HMAC-SHA1",
        :scheme => 'header'
      })

      timestamp = Time.now.to_i
      nonce = SecureRandom.uuid
      options = {
              :timestamp => timestamp,
              :nonce => nonce
      }
      url = Addressable::URI.parse(request.url)
      if request.get_params.any?
        url.query_values = (url.query_values || {}).merge request.get_params
      end
      url = url.to_s

      req = consumer.create_signed_request(request.method[:method], url, nil, options)
      
      request.headers['Authorization'] = req['Authorization']
      unless self.class.vendor_key.blank? && self.class.vendor_secret.blank?
        request.headers['x-vendor-authorization'] = "#{self.class.vendor_key}:#{self.class.vendor_secret}"
      end
    end
  end
end
