class RemoveStatusFromLoans < ActiveRecord::Migration
  def change
    remove_column :loans, :status, :string
  end
end
