class Survey < ApplicationRecord
  has_many :survey_questions
  has_many :survey_responses

  accepts_nested_attributes_for :survey_questions, reject_if: :all_blank
end
