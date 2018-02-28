class Node < ApplicationRecord
  validates :machine_id, uniqueness: true, presence: true 

  def abbr_machine_id
    machine_id[0..6]
  end

  def last_seen_at
    pinged_at || created_at
  end
end
