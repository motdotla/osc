class AddHashesCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hashes_count, :integer
  end
end
