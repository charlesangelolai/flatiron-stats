class User < ApplicationRecord
  include PublicActivity::Model
  tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :cohort
  belongs_to :role
  has_many :projects
  has_many :survey_responses, through: :projects
  has_many :posts
  has_many :comments, through: :posts
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
  
  accepts_nested_attributes_for :cohort, reject_if: :all_blank
end
