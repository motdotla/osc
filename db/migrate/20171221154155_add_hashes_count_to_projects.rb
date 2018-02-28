class AddHashesCountToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :hashes_count, :integer
  end
end
