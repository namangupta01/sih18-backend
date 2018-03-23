class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
    	t.string :message
    	t.integer :notification_type
    	t.string :author
    	t.references :dam
    	t.integer :resource_id
      t.timestamps
    end
  end
end
