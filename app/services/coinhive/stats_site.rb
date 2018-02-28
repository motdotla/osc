# frozen_string_literal: true

module Coinhive
  class StatsSite
    def run
      Coinhive::Client.new(attrs).run
    end

    private

    def attrs
      {
        path: path,
        params: params
      }
    end

    def secret
      ENV['COINHIVE_SECRET']
    end

    def params
      URI.encode_www_form(secret: secret)
    end

    def path
      '/stats/site'
    end
  end
end

