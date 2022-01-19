require 'active_record'

class Quiz < ActiveRecord::Base
  has_and_belongs_to_many :category
  has_many :question, :dependent => :destroy
  belongs_to :user
end