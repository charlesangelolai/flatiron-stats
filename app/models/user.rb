class User < ApplicationRecord
  has_many :projects
  has_many :survey_questions, through: :projects
end
