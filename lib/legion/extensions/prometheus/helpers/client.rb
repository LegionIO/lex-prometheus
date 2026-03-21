# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Prometheus
      module Helpers
        module Client
          def connection(url: nil, username: nil, password: nil, **_opts)
            base_url = url || 'http://prometheus:9090'
            Faraday.new(url: base_url) do |conn|
              conn.response :json, content_type: /\bjson$/
              conn.request :authorization, :basic, username, password if username && password
              conn.adapter Faraday.default_adapter
            end
          end
        end
      end
    end
  end
end
