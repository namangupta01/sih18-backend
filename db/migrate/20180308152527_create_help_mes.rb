class CreateHelpMes < ActiveRecord::Migration[5.1]
  def change
    create_table :help_mes do |t|
    	t.string :latitude
    	t.string :longitude
    	t.string :address
    	t.references :user
    	t.references :dam
      	t.timestamps
    end
  end
end
