class User < ActiveRecord::Base
  has_many :quiz, :dependent => :destroy
end
