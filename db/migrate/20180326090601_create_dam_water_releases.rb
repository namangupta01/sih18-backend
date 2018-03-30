class CreateDamWaterReleases < ActiveRecord::Migration[5.1]
  def change
    create_table :dam_water_releases do |t|
    	t.references :dam
    	t.references :dam_admin
    	t.string :description
    	t.string :water_release_datetime
      t.timestamps
    end
  end
end
