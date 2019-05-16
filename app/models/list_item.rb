class ListItem < ApplicationRecord
  belongs_to :user
  belongs_to :list_type

  validates :title, presence: true
  validates :list_type_id, presence: { message: 'must show a list for it to go on.' }
end
