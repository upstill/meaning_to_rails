class User < ApplicationRecord
  # attr_accessible :name, :password, :password_confirmation
  has_secure_password
  has_many :list_items

  # Find (or create, if not priorly existing) a user from the response to an omniauth login
  def self.from_omniauth(auth)
    find_by(auth.slice("provider", "uid")) || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end
end
