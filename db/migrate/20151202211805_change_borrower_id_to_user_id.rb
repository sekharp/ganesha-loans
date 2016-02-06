class ChangeBorrowerIdToUserId < ActiveRecord::Migration
  def change
    rename_column :projects, :borrower_id, :user_id
  end
end
