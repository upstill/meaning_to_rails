class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :users if ActiveRecord::Base.connection.table_exists?("users")
    create_table :users do |t|
      t.string :name
      t.string :password_digest

      t.timestamps
    end
  end
end
