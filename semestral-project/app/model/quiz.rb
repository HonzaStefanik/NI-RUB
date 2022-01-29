require 'active_record'

class Quiz < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :questions, :dependent => :destroy
  belongs_to :user
end