class AddStarsCountAndLanguageToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :language, :string
    add_column :projects, :stars_count, :integer
  end
end
