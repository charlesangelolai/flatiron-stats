class Category < ApplicationRecord
  has_many :posts, dependent: :delete_all
end
