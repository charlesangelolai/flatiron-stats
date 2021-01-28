class Survey < ApplicationRecord
  has_many :survey_questions
  has_many :survey_responses
end
