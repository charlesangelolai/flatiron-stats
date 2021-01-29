class Project < ApplicationRecord
  belongs_to :user
  has_many :surveys
  has_many :survey_responses, through: :surveys
end
