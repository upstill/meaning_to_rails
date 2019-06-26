class User < ApplicationRecord
  # attr_accessible :name, :password, :password_confirmation
  # has_secure_password
  has_many :list_items

  # Find (or create, if not priorly existing) a user from the response to an omniauth login
  def self.from_omniauth(auth)
    find_by(auth.slice("provider", "uid")) || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      # Get the user's name from the info obtained by the provider
      info = auth['info']
      user.name = case auth['provider']
      when 'twitter'
        info["nickname"]
      when 'google'
      when 'identity'
        info['name']
      end || info['email']
      # identity = Identity.find_by(name: user.name)
      # user.password_digest = identity.password_digest # "$2a$10$8WfW//lsMTqySxVqyTGAZe506/r.8zJf/NbqKy8bVhSIISYwB14dS"
    end
  end
end
