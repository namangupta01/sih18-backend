class CreateDirectories < ActiveRecord::Migration[5.1]
  def change
    create_table :directories do |t|
    	t.string :name
    	t.string :phone_number
    	t.references :dam
      	t.timestamps
    end
  end
end
