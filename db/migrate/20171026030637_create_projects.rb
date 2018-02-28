class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :url

      t.timestamps
    end
    add_index :projects, :url, unique: true
  end
end
