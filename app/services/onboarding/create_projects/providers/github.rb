# frozen_string_literal: true

module Onboarding
  module CreateProjects
    module Providers
      class Github
        attr_accessor :user_id

        def initialize(user_id:)
          self.user_id = user_id
        end

        def run
          repos = fetch_repos

          repos.each do |repo|
            FindOrCreateProject.new(user_id: user_id,
                                    url: repo.html_url,
                                    stars_count: repo.stargazers_count,
                                    language: repo.language).run
          end
        end

        private

        def fetch_repos
          github.repos.list user: user.nickname, type: 'owner', sort: 'updated'
        end

        def github
          @github ||= ::Github.new(attrs)
        end

        def attrs
          {
            per_page: per_page,
            oauth_token: oauth_token
          }.compact
        end

        def user
          @user = User.find(user_id)
        end

        def per_page
          100
        end

        def oauth_token
          user.oauth_token
        end
      end
    end
  end
end
