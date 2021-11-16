class School < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true
  has_many :people, dependent: :destroy
end
