# frozen_string_literal: true

class SetUserStats
  attr_accessor :user_id

  def initialize(user_id:)
    self.user_id = user_id
  end

  def run
    if should_update?
      ActiveRecord::Base.transaction do
        user.update_column(:hashes_count, result['total'])
      end
    end
  end

  private

  def result
    @result ||= Coinhive::UserBalance.new(name: name).run
  end

  def name
    "citizen:#{user.id}"
  end

  def user
    @user ||= User.find(user_id)
  end

  def hashes_count
    user.hashes_count.to_i
  end

  def should_update?
    result['total'] && hashes_count < result['total']
  end
end
