class AddTimestampsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.column  :created_at , :timestamp, null: true
      t.column  :updated_at , :timestamp, null: true
    end
  end
end
