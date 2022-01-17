class Quiz < ActiveRecord::Base
  has_many :category
  has_many :question, :dependent => :destroy
  belongs_to :user
end