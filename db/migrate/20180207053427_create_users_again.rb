class CreateUsersAgain < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :auth0_uid
      t.string :name
      t.string :nickname
      t.string :profile_photo_url
      t.string :email
      t.string :provider
      t.boolean :has_new_project_data, default: false
    end
  end
end
