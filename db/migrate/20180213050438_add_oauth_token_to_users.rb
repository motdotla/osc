class AddOauthTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :oauth_token, :string
  end
end
