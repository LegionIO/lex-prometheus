# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/queries'
require_relative 'runners/alerts'

module Legion
  module Extensions
    module Prometheus
      class Client
        include Helpers::Client
        include Runners::Queries
        include Runners::Alerts

        attr_reader :opts

        def initialize(url:, username: nil, password: nil, **extra)
          @opts = { url: url, username: username, password: password, **extra }
        end

        def settings
          { options: @opts }
        end

        def connection(**override)
          super(**@opts, **override)
        end
      end
    end
  end
end
