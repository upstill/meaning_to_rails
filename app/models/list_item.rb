class ListItem < ApplicationRecord
  belongs_to :user
  belongs_to :list_type

  # There must be a title
  validates :title, presence: true
  # ...and it must be unique within the owner and the type of list
  validates :title, uniqueness: { scope: [:user_id, :list_type_id],
                                 message: "must be unique" }
  validates :list_type_id, presence: { message: 'must be included in a list.' }

  # Extract item data from an array of fields, where the title has already been extracted
  def import fields, title_too=false
    self.title = fields.shift if title_too
    fields.each do |field|
      field.strip!
      next if field.blank?
      # Assign to either description or link, depending on whether it's parseable as a URI
      if !field.match(/\s/)
        begin
          if URI(field)
            self.link = field
            next
          end
        rescue e   # Ignore URI parsing errors
          x = 2
        end
      end
      self.description = field
    end
    self
  end
end
