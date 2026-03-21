# frozen_string_literal: true

module Legion
  module Extensions
    module Prometheus
      module Runners
        module Alerts
          def list_alerts(**)
            resp = connection(**).get('/api/v1/alerts')
            { alerts: resp.body }
          end

          def list_rules(**)
            resp = connection(**).get('/api/v1/rules')
            { rules: resp.body }
          end
        end
      end
    end
  end
end
