class AddHelpToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :help, :boolean, default: false
  end
end
