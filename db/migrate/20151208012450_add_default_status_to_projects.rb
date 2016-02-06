class AddDefaultStatusToProjects < ActiveRecord::Migration
  def change
    change_column_default :projects, :status, "Pending"
  end
end
