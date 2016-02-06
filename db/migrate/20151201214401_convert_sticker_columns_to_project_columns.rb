class ConvertStickerColumnsToProjectColumns < ActiveRecord::Migration
  def change
    rename_column :projects, :price, :goal_amount
    add_reference :projects, :borrower, index: true
  end
end
