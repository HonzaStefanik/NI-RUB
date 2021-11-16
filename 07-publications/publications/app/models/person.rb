class Person < ApplicationRecord
  belongs_to :school
  has_many :publications, dependent: :destroy
  validates :full_name, presence: true
  validates :username, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
