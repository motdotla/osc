# frozen_string_literal: true

require 'uri'

class FindOrCreateUser
  def initialize(omniauth_response:)
    @omniauth_response = omniauth_response 
  end

  def run
    if existing_user
      existing_user.update_attributes!(user_attrs)
      existing_user.reload
    else
      create_user
    end
  end

  private

  def existing_user
    @existing_user ||= User.find_by(uid: uid)
  end

  def create_user
    @user ||= begin
      User.create!(user_attrs)
    rescue ActiveRecord::RecordInvalid
      nil
    end
  end

  def user_attrs
    {
      uid: uid,
      name: name,
      email: email,
      nickname: nickname || username,
      profile_photo_url: profile_photo_url || extra_links_avatar_href,
      provider: provider,
      oauth_token: oauth_token
    }
  end

  def uid
    return nil unless raw_uid.present?

    "#{provider}|#{raw_uid}"
  end

  def raw_uid
    @omniauth_response['uid'].to_s
  end

  def info
    @info ||= @omniauth_response['info']
  end

  def name
    info['name']
  end

  def nickname
    info['nickname']
  end

  def username
    info['username'] # Bitbucket
  end

  def email
    info['email']
  end

  def profile_photo_url
    info['image']
  end

  def extra_links_avatar_href
    @omniauth_response['extra'].try(:[], 'links').try(:[], 'avatar').try(:[], 'href')
  end

  def provider
    @omniauth_response['provider']
  end

  def oauth_token
    @omniauth_response['credentials'].try(:[], 'token')
  end
end
