class CreateUserLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_locations do |t|
    	t.float :latitude
    	t.float :longitude
    	t.references :user
      	t.timestamps
    end
  end
end
