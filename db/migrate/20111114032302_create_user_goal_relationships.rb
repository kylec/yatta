class CreateUserGoalRelationships < ActiveRecord::Migration
  def change
    create_table :user_goal_relationships do |t|
      t.integer :user_id
      t.integer :goal_id

      t.timestamps
    end
    add_index :user_goal_relationships, :user_id
    add_index :user_goal_relationships, :goal_id
    add_index :user_goal_relationships, [:user_id, :goal_id], :unique => true
  end
  
  def self.down
    drop_table :user_goal_relationships
  end
end
