class CreateDamAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :dam_admins do |t|
    	t.string :name
    	t.string :password
    	t.string :email
    	t.string :phone_number
    	t.references :dam
      	t.timestamps
    end
  end
end
