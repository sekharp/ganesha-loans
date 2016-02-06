class AddAmountToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :amount, :money
  end
end
