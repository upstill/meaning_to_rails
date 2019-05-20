class AddSourceToListType < ActiveRecord::Migration[5.0]
  def change
    add_column :list_types, :refstr, :text
    add_column :list_types, :refurl, :text
  end
end
