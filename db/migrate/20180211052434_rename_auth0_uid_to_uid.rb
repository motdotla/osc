class RenameAuth0UidToUid < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :auth0_uid, :uid
  end
end
