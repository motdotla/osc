module Onboarding
  module CreateProjects
    class Index
      attr_accessor :user_id

      def initialize(user_id:)
        self.user_id = user_id
      end

      def run
        case provider
        when 'bitbucket'
          Onboarding::CreateProjects::Providers::Bitbucket.new(user_id: user.id).run
        when 'github'
          Onboarding::CreateProjects::Providers::Github.new(user_id: user.id).run
        else
          raise "Provider #{provider} does not exist!"
        end
      end

      private

      def provider
        user.provider
      end

      def user
        @user ||= User.find(user_id)
      end
    end
  end
end
