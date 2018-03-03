class CreateDams < ActiveRecord::Migration[5.1]
  def change
    create_table :dams do |t|
    	t.string :project_identification_code
    	t.string :name_of_dam
    	t.string :operated_and_maintained_by
    	t.string :longitude_of_dam
    	t.string :latitude_of_dam
    	t.string :year_of_completion
    	t.string :river_basin
    	t.string :river
    	t.string :nearest_city
    	t.string :seismic_zone
    	t.string :type_of_dam
    	t.string :height_above_lowest_foundation
    	t.string :length_of_dam
    	t.string :volume_content_of_dam
    	t.string :gross_storage_capacity
    	t.string :reservoir_area
    	t.string :effective_storage_capacity
    	t.string :purpose
    	t.string :designed_spillway_capacity
    	t.string :state
    	t.string :present_water_level
      	t.timestamps
    end
  end
end
