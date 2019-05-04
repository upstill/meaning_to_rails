class ChangeListItem < ActiveRecord::Migration[5.0]
  def change
    rename_column :list_items, :list_id, :list_type_id
  end
end
