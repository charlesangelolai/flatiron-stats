class Cohort < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: true
  validates :program, presence: true
  validates :time, presence: true
end
