# frozen_string_literal: true

module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end

    def json_error
      json['errors']
    end
  end
end
