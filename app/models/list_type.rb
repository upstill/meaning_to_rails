class ListType < ApplicationRecord
  mount_uploader :import, ImportUploader # Tells rails to use this uploader for this model.

  def noun plural=false
    n = noun_spec.if_present || title.split[2..-1].join(' ')
    plural ? n.pluralize : n
  end

  def verb
    verb_spec.if_present || title.split.first
  end

  def imports user_id
    @imports ||= if import && (contents = import.read)
                   contents.split("\n").collect { |line|
                     fields = line.split("\t");
                     item = ListItem.new(
                         list_type_id: id,
                         user_id: user_id,
                         title: fields.shift
                     )
                     next if ListItem.exists?(title: item.title)
                     fields.each do |field|
                       field.strip!
                       next if field.blank?
                       # Assign to either description or link, depending on whether it's parseable as a URI
                       if !field.match(/\s/)
                         begin
                           if URI(field)
                             item.link = field
                             next
                           end
                         rescue e
                           x = 2
                         end
                       end
                       item.description = field
                     end
                     item
                   }.compact
                 end
  end
end
