class Project < ApplicationRecord
  has_many :user_projects
  has_many :users, through: :user_projects

  default_scope { order('hashes_count desc nulls last', 'stars_count desc nulls last') }

  validates :url, uniqueness: true, presence: true

  def linkable_url
    "http://#{url}"
  end
end
