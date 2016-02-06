class AddProjectIdToLoans < ActiveRecord::Migration
  def change
    add_reference :loans, :project, index: true, foreign_key: true
  end
end
