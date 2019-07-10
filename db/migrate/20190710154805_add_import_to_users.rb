class AddImportToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :list_types, :import, :string
    add_column :users, :import, :string
    add_column :users, :import_type_id, :integer
  end
end
