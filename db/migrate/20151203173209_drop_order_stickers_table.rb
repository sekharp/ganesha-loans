class DropOrderStickersTable < ActiveRecord::Migration
  def change
    drop_join_table :order, :stickers
  end
end
