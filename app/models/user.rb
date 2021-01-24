class User < ApplicationRecord
  has_many :projects
  has_many :surveys, through: :projects
end
