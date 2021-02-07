class User < ApplicationRecord
  include PublicActivity::Model
  tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :cohort, optional: true
  belongs_to :role
  has_many :projects, dependent: :delete_all
  has_many :survey_responses, through: :projects, dependent: :delete_all
  has_many :posts, dependent: :delete_all
  has_many :comments, through: :posts, dependent: :delete_all
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable, omniauth_providers: [:github]
  
  accepts_nested_attributes_for :cohort, reject_if: :all_blank

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name = auth.info.name.split(' ').first
      user.last_name = auth.info.name.split(' ').second
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.search(params)
    where("LOWER(first_name) || ' ' || LOWER(last_name) LIKE :s OR LOWER(email) LIKE :s", :s => "%#{params.downcase}%")
  end
end
