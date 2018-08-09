module Oneroster
  # https://oneroster.infinitecampus.org/campus/oneroster/entropyMaster/ims/oneroster/v1p1/
  class AcademicSession < Oneroster::ApiBase
    get :all, "/academicSessions"
    get :find, "/academicSessions/:id"
  end
  class Administrator < Oneroster::ApiBase
    get :all, "/administrators", ignore_root: 'users'
    get :find, "/administrators/:id", ignore_root: 'users'
  end
  class CampusVersion < Oneroster::ApiBase
    get :version, "/campusVersion"
  end
  class Category < Oneroster::ApiBase
    get :all, "/categories", ignore_root: 'categories'
    get :find, "/categories/:id", ignore_root: 'categories'
  end
  class Class < Oneroster::ApiBase
    get :all, "/classes", ignore_root: 'classes'
    get :find, "/classes/:id", ignore_root: 'classes'
    get :line_items, "/classes/:id/lineItems"
    get :line_item_results, "/classes/:id/lineItems/:line_item_id/results"
    get :results, "/classes/:id/results"
    get :students, "/classes/:id/students", ignore_root: 'users'
    get :student_results, "/classes/:id/students/:student_id/results"
    get :teachers, "/classes/:id/teachers", ignore_root: 'users'
  end
  class Course < Oneroster::ApiBase
    get :all, "/courses", ignore_root: 'courses'
    get :find, "/courses/:id"
    get :classes, "/courses/:id/classes"
  end
  class Demographic < Oneroster::ApiBase
    get :all, "/demographics", ignore_root: 'demographics', timeout: 100
    get :find, "/demographics/:id", ignore_root: 'demographics', timeout: 100
  end
  class District < Oneroster::ApiBase
    get :all, "/districts", ignore_root: 'orgs'
  end
  class Enrollment < Oneroster::ApiBase
    get :all, "/enrollments", ignore_root: 'enrollments'
    get :find, "/enrollments/:id", ignore_root: 'enrollments'
  end
  class GradingPeriod < Oneroster::ApiBase
    get :all, "/gradingPeriods", ignore_root: 'academicSession'
    get :find, "/gradingPeriods/:id", ignore_root: 'academicSession'
  end
  class Guardian < Oneroster::ApiBase
    get :all, "/guardians", ignore_root: 'users'
    get :find, "/guardians/:id", ignore_root: 'users'
  end
  class Lineitem < Oneroster::ApiBase
    get :all, "/lineItems", ignore_root: 'lineItems'
    delete :line_item, "/lineItems/:id"
    get :find, "/lineItems/:id"
    put :line_item, "/lineItems/:id"
    delete :student_result, "/lineItems/:id/students/:student_id/results/:result_id"
    get :student_result, "/lineItems/:id/students/:student_id/results/:result_id"
    put :student_result, "/lineItems/:id/students/:student_id/results/:result_id"
  end
  class Org < Oneroster::ApiBase
    get :all, "/orgs"
    get :find, "/orgs/:id"
  end
  class Relative < Oneroster::ApiBase
    get :all, "/relatives"
    get :find, "/relatives/:id"
  end
  class Result < Oneroster::ApiBase
    get :all, "/results", ignore_root: 'results'
    get :find, "/results/:id", ignore_root: 'results'
    delete :result, "/results/:id", ignore_root: 'results'
    put :result, "/results/:id", ignore_root: 'results'
  end
  class School < Oneroster::ApiBase
    get :all, "/schools", ignore_root: 'orgs', timeout: 100
    get :find, "/schools/:id", ignore_root: 'org'
    get :administrators, "/schools/:id/administrators"
    get :classes, "/schools/:id/classes", ignore_root: 'classes', timeout: 100
    get :class_enrollments, "/schools/:id/classes/:class_id/enrollments"
    get :class_students, "/schools/:id/classes/:class_id/students", timeout: 100
    get :class_teachers, "/schools/:id/classes/:class_id/teachers", timeout: 100
    get :courses, "/schools/:id/courses"
    get :enrollments, "/schools/:id/enrollments"
    get :student_enrollments, "/schools/:id/studentEnrollments"
    get :students, "/schools/:id/students", ignore_root: 'users', timeout: 100
    get :teacher_enrollments, "/schools/:id/teacherEnrollments"
    get :teachers, "/schools/:id/teachers", ignore_root: 'users', timeout: 100
    get :terms, "/schools/:id/terms"
  end
  class Scoregroup < Oneroster::ApiBase
    get :all, "/scoreGroups", ignore_root: 'scoreGroups'
    get :find, "/scoreGroups/:id", ignore_root: 'scoreGroups'
  end
  class StudentEnrollment < Oneroster::ApiBase
    get :all, "/studentEnrollments"
  end
  class Student < Oneroster::ApiBase
    get :all, "/students", ignore_root: 'users', timeout: 100
    get :find, "/students/:id", ignore_root: 'users'
    get :classes, "/students/:id/classes", ignore_root: 'users', timeout: 100
    get :results, "/students/:id/results", ignore_root: 'users', timeout: 100
  end
  class TeacherEnrollment < Oneroster::ApiBase
    get :all, "/teacherEnrollments"
  end
  class Teacher < Oneroster::ApiBase
    get :all, "/teachers", ignore_root: 'users', timeout: 100
    get :find, "/teacher/:id", ignore_root: 'user'
    get :classes, "/teacher/:id/classes", timeout: 100
  end
  class Term < Oneroster::ApiBase
    get :all, "/terms", ignore_root: 'academicSessions'
    get :find, "/terms/:id", ignore_root: 'academicSession'
    get :classes, "/terms/:id/classes"
    get :grading_periods, "/terms/:id/gradingPeriods"
  end
  class User < Oneroster::ApiBase
    get :all, "/users", ignore_root: 'users', timeout: 100
    get :find, "/user/:id", ignore_root: 'users'
    get :classes, "/user/:id/classes", timeout: 100
  end
end
