class AddHasNewProjectDataToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :has_new_project_data, :boolean, default: false
  end
end
