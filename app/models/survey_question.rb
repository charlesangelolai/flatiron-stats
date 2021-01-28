class SurveyQuestion < ApplicationRecord
  belongs_to :survey

  # accepts_nested_attributes_for :survey, reject_if: :all_blank
end
