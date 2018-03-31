class CreateUserHelpingMappings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_helping_mappings do |t|
    	t.integer :helper
    	t.integer :whom_want_help
      	t.timestamps
    end
  end
end
