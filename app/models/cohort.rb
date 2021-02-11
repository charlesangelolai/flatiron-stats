class Cohort < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  has_many :users, dependent: :delete_all

  validates :name, presence: true, uniqueness: true
end
