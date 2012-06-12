class AddIndexToGoalsTitle < ActiveRecord::Migration
  def up
    add_index :goals, :title
  end

  def down
    remove_index :goals, :title
  end
end
