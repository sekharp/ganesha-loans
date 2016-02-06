class ChangeOrdersToLoans < ActiveRecord::Migration
  def change
    rename_table :orders, :loans
  end
end
