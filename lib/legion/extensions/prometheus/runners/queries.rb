# frozen_string_literal: true

module Legion
  module Extensions
    module Prometheus
      module Runners
        module Queries
          def instant_query(query:, time: nil, **)
            params = { query: query }
            params[:time] = time if time
            resp = connection(**).get('/api/v1/query', params)
            { result: resp.body }
          end

          def range_query(query:, step:, start: nil, end_time: nil, **)
            params = { query: query, step: step }
            params[:start] = start if start
            params[:end]   = end_time if end_time
            resp = connection(**).get('/api/v1/query_range', params)
            { result: resp.body }
          end

          def series(match:, start: nil, end_time: nil, **)
            params = { 'match[]' => match }
            params[:start] = start if start
            params[:end]   = end_time if end_time
            resp = connection(**).get('/api/v1/series', params)
            { series: resp.body }
          end

          def labels(**)
            resp = connection(**).get('/api/v1/labels')
            { labels: resp.body }
          end

          def label_values(label_name:, **)
            resp = connection(**).get("/api/v1/label/#{label_name}/values")
            { values: resp.body }
          end
        end
      end
    end
  end
end
