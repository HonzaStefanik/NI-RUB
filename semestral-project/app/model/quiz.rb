class Quiz < ActiveRecord::Base
  has_many :category
  has_many :question
  belongs_to :user
end