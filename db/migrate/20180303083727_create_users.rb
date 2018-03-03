class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :phone_number
      t.boolean :confirmed, default: false
      t.string :confirmation_token
      t.timestamps
    end
  end
end
