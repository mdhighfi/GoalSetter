class UpdateGoalBooleans < ActiveRecord::Migration
  def change
    change_column :goals, :private, :boolean, null: false, default: false
    change_column :goals, :completed, :boolean, null: false, default: false
  end
end
