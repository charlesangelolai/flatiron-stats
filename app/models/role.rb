class Role < ApplicationRecord
  has_many :users

  def is_admin?
    current_user.role_id == 1
  end
end
