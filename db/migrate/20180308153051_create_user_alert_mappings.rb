class CreateUserAlertMappings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_alert_mappings do |t|
    	t.integer :help
    	t.integer :helper
      t.timestamps
    end
  end
end
