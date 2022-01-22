require 'active_record'

class User < ActiveRecord::Base
  has_many :quizzes, :dependent => :destroy
  has_secure_password
end
