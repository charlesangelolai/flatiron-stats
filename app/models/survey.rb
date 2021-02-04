class Survey < ApplicationRecord
  has_many :survey_questions
  has_many :survey_responses

  validates :name, presence: true
  validates :phase_num, presence: true

  accepts_nested_attributes_for :survey_questions, reject_if: :all_blank
end
