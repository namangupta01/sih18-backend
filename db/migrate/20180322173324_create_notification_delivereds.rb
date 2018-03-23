class CreateNotificationDelivereds < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_delivereds do |t|
    	t.references :user
    	t.datetime :date_time
      	t.timestamps
    end
  end
end
