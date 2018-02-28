# frozen_string_literal: true

require 'ostruct'

module Onboarding
  module CreateProjects
    module Providers
      class Bitbucket
        API_URL = 'https://api.bitbucket.org/2.0'

        attr_accessor :user_id

        def initialize(user_id:)
          self.user_id = user_id
        end

        def run
          repos = fetch_repos

          repos.each do |repo|
            FindOrCreateProject.new(user_id: user_id,
                                    url: repo.html_url,
                                    language: repo.language).run
          end
        end

        private

        def fetch_repos
          result = conn.get do |req|
            req.url(full_path)
            req.headers = headers
          end

          raise result.body unless result.status < 300 # 200 status only

          format Oj.load(result.body)
        end

        def full_path
          "repositories/#{user.nickname}?pagelen=#{per_page}"
        end

        def user
          @user ||= User.find(user_id)
        end

        def conn
          @conn ||= Faraday.new(url: API_URL)
        end

        def headers
          {}
        end

        def format(body)
          body['values'].map do |repo|
            OpenStruct.new(html_url: repo['links']['html']['href'],
                           language: repo['language'])
          end
        end

        def per_page
          100
        end
      end
    end
  end
end
