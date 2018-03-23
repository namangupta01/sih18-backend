class AddDamReferenceToAdmin < ActiveRecord::Migration[5.1]
  def change
  	add_reference :admins, :dam, index: true
  end
end
