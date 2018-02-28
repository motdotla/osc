class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :auth0_uid, unique: true
      t.string :name
      t.string :nickname
      t.string :profile_photo_url
      t.string :email
    end
  end
end
