class AddTitleAndDescriptionToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :title, :string
    add_column :goals, :description, :string
  end
end
