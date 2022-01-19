require 'active_record'

class Question < ActiveRecord::Base
  has_many :answer, :dependent => :destroy
  belongs_to :quiz
end