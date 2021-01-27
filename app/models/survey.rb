class Survey < ApplicationRecord
  belongs_to :project
  has_many :survey_questions
  has_many :survey_responses
end
