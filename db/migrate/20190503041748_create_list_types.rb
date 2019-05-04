class CreateListTypes < ActiveRecord::Migration[5.0]
  def change
    drop_table :list_types if ActiveRecord::Base.connection.table_exists?("list_types")
    create_table :list_types do |t|
      t.text :title
      t.string :noun_spec
      t.string :verb_spec

      t.timestamps
    end
  end
end
