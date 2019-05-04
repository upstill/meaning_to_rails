class User < ApplicationRecord
  # attr_accessible :name, :password, :password_confirmation
  has_secure_password
  has_many :list_items
end
