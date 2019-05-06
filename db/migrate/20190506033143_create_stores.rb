class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :control_number
      t.string :password_digest, limit: 191
      t.string :remember_token

      t.timestamps
    end
  end
end
