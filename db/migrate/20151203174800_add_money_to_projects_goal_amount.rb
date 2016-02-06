class AddMoneyToProjectsGoalAmount < ActiveRecord::Migration
  def change
    remove_column :projects, :goal_amount, :decimal
    add_column :projects, :goal_amount, :money
  end
end
