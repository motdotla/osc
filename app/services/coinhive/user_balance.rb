# frozen_string_literal: true

module Coinhive
  class UserBalance
    attr_accessor :name

    def initialize(name:)
      self.name = name
    end

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
      URI.encode_www_form(secret: secret, name: name)
    end

    def path
      '/user/balance'
    end
  end
end

