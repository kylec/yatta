class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.integer :goal_id
      t.string :title
      t.string :description
      t.integer :position
      t.timestamps
    end
  end
end
