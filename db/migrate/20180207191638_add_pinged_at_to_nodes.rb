class AddPingedAtToNodes < ActiveRecord::Migration[5.1]
  def change
    add_column :nodes, :pinged_at, :datetime
  end
end
