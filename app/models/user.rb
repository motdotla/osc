class User < ApplicationRecord
  validates :uid, uniqueness: true, presence: true 

  has_many :user_projects
  has_many :projects, through: :user_projects
end
