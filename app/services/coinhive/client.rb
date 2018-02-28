# frozen_string_literal: true

module Coinhive
  class Client
    API_URL = 'https://api.coinhive.com'

    attr_accessor :path, :params, :http_method

    def initialize(path:, params:, http_method: nil)
      self.path = path
      self.params = params
      self.http_method = http_method || default_http_method
    end

    def run
      result = conn.send(http_method) do |req|
        req.url(full_path)
        req.headers = headers
        # req.body = params
      end

      raise result.body unless result.status < 300 # 200 status only

      Oj.load(result.body)
    end

    private

    def full_path
      "#{path}?#{params}"
    end

    def headers
      {}
    end

    def conn
      @conn ||= Faraday.new(url: API_URL)
    end

    def default_http_method
      'get'
    end
  end
end

