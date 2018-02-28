module Shared
  module NormalizedUrl
    # assumes a url attribute on the object
    def normalized_url
      "#{host_without_www}#{parsed_url.path}"
    end

    private

    def host_without_www
      return nil unless parsed_url.host

      @host_without_www ||= parsed_url.host.gsub(/www\./i, '')
    end

    def parsed_url
      @parsed_url ||= begin
        URI.parse(stripped_url)
      rescue
        "http://#{stripped_url}"
      end
    end

    def stripped_url
      @stripped_url ||= url.to_s.strip
    end
  end
end
