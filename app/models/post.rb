class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :delete_all

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
end
