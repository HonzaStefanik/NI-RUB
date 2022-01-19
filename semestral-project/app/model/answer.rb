require 'active_record'

class Answer < ActiveRecord::Base
  belongs_to :quiz
end
