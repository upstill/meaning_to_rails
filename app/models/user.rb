class User < ApplicationRecord
  # A user holds an import file pending acceptance of the items therefrom
  # mount_uploader :import, ImportUploader # Tells rails to use this uploader for this model.
  has_one_attached :import
  belongs_to :import_type, class_name: 'ListType', optional: true
  
  # attr_accessible :name, :password, :password_confirmation
  # has_secure_password
  has_many :list_items

  def items_from_list list_type
    list_items.where(list_type: list_type).order :title
  end

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

  # Elide bcrypt authentication (which requires a password_digest attribute)
  # by resorting to the user's omniauth Identity, if any
  def authenticate_via_identity password
    (provider == 'identity') &&
    (id = Identity.find_by_id(uid)) &&
    id.authenticate(password)
  end

  # What are the items pending in the imports list?
  def imports
    return @imports if @imports
    if import &&
        import.attached? &&
        (self.import_contents = import.download rescue nil)
      @imports =
          import_contents.
              split("\n").
              collect {|line|
                fields = line.split("\t");
                item = ListItem.find_or_initialize_by(
                    list_type_id: import_type_id,
                    user_id: id,
                    title: fields.shift
                )
                item.import(fields) unless item.persisted? # No redundancy, please!
              }.compact
    end
  end

  def imports= ilist
    @imports = ilist
  end
end
