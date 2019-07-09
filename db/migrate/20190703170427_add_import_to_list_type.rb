class AddImportToListType < ActiveRecord::Migration[5.0]
  def change
    add_column :list_types, :import, :string
  end
end
