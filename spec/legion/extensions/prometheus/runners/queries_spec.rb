# frozen_string_literal: true

RSpec.describe Legion::Extensions::Prometheus::Runners::Queries do
  let(:client) do
    Legion::Extensions::Prometheus::Client.new(url: 'http://prometheus:9090')
  end

  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:test_connection) do
    Faraday.new(url: 'http://prometheus:9090') do |conn|
      conn.response :json, content_type: /\bjson$/
      conn.adapter :test, stubs
    end
  end

  before { allow(client).to receive(:connection).and_return(test_connection) }

  describe '#instant_query' do
    it 'returns query result' do
      stubs.get('/api/v1/query') do
        [200, { 'Content-Type' => 'application/json' },
         { 'status' => 'success', 'data' => { 'resultType' => 'vector', 'result' => [] } }]
      end
      result = client.instant_query(query: 'up')
      expect(result[:result]['status']).to eq('success')
    end
  end

  describe '#range_query' do
    it 'returns range query result' do
      stubs.get('/api/v1/query_range') do
        [200, { 'Content-Type' => 'application/json' },
         { 'status' => 'success', 'data' => { 'resultType' => 'matrix', 'result' => [] } }]
      end
      result = client.range_query(query: 'up', start: '2026-01-01T00:00:00Z', end_time: '2026-01-02T00:00:00Z', step: '1h')
      expect(result[:result]['status']).to eq('success')
    end
  end

  describe '#series' do
    it 'returns matching series' do
      stubs.get('/api/v1/series') do
        [200, { 'Content-Type' => 'application/json' },
         { 'status' => 'success', 'data' => [{ '__name__' => 'up', 'job' => 'prometheus' }] }]
      end
      result = client.series(match: 'up')
      expect(result[:series]['status']).to eq('success')
      expect(result[:series]['data']).to be_an(Array)
    end
  end

  describe '#labels' do
    it 'returns label names' do
      stubs.get('/api/v1/labels') do
        [200, { 'Content-Type' => 'application/json' },
         { 'status' => 'success', 'data' => %w[__name__ job instance] }]
      end
      result = client.labels
      expect(result[:labels]['status']).to eq('success')
      expect(result[:labels]['data']).to include('job')
    end
  end

  describe '#label_values' do
    it 'returns values for a label' do
      stubs.get('/api/v1/label/job/values') do
        [200, { 'Content-Type' => 'application/json' },
         { 'status' => 'success', 'data' => %w[prometheus node] }]
      end
      result = client.label_values(label_name: 'job')
      expect(result[:values]['status']).to eq('success')
      expect(result[:values]['data']).to include('prometheus')
    end
  end
end
