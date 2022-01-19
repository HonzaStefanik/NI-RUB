require 'active_record'
require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :quiz, :dependent => :destroy

  def password
    @password ||= Password.new(hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.hash = @password
  end
end
