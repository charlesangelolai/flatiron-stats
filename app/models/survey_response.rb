class SurveyResponse < ApplicationRecord
  belongs_to :survey
  belongs_to :project

  validates :design_response, presence: true
  validates :navigation_response, presence: true
  validates :error_handling_response, presence: true
end