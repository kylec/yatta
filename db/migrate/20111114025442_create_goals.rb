class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :user_id

      t.timestamps
    end
  end
	
	def self.down
    drop_table :goals
  end
end
