class CreateUserGoalCommentRelationships < ActiveRecord::Migration
  def change
    create_table :user_goal_comment_relationships do |t|
      t.integer :user_goal_relationship_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :user_goal_comment_relationships
  end
end
