class ListItem < ApplicationRecord
  belongs_to :user
  belongs_to :list_type
end
