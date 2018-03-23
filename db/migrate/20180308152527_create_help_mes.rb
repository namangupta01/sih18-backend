class CreateHelpMes < ActiveRecord::Migration[5.1]
  def change
    create_table :help_mes do |t|
    	t.float :latitude
    	t.float :longitude
    	t.string :address
    	t.references :user
    	t.references :dam
      	t.timestamps
    end
  end
end
