require 'active_record'

class User < ActiveRecord::Base
  has_many :quiz, :dependent => :destroy
  has_secure_password
end
