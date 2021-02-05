class Survey < ApplicationRecord
  has_many :survey_questions, dependent: :delete_all
  has_many :survey_responses, dependent: :delete_all

  validates :name, presence: true
  validates :phase_num, presence: true

  accepts_nested_attributes_for :survey_questions, reject_if: :all_blank
end
