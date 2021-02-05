class Project < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  validates :name, presence: true
  validates :phase_num, presence: true
  validates :description, presence: true
  validates :website_link, presence: true
  validates :github_link, presence: true
  validates :blog_link, presence: true
  validates :video_link, presence: true

  belongs_to :user
  has_many :survey_responses, dependent: :delete_all
end
