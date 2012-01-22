class CreateUserGoalMilestoneRelationships < ActiveRecord::Migration
  def change
    create_table :user_goal_milestone_relationships do |t|
      t.integer :user_goal_relationship_id
      t.integer :milestone_id

      t.timestamps
    end
  end
end
