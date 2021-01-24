class SurveyResponse < ApplicationRecord
  belongs_to :survey
  belongs_to :project
  belongs_to :user
end
