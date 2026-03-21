# frozen_string_literal: true

require 'legion/extensions/prometheus/version'
require 'legion/extensions/prometheus/helpers/client'
require 'legion/extensions/prometheus/runners/queries'
require 'legion/extensions/prometheus/runners/alerts'
require 'legion/extensions/prometheus/client'

module Legion
  module Extensions
    module Prometheus
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
