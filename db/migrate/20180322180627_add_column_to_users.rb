class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_reference :users, :dam, index: true
  end
end
