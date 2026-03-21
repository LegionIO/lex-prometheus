# frozen_string_literal: true

RSpec.describe Legion::Extensions::Prometheus::Runners::Alerts do
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

  describe '#list_alerts' do
    it 'returns active alerts' do
      stubs.get('/api/v1/alerts') do
        [200, { 'Content-Type' => 'application/json' },
         { 'status' => 'success', 'data' => { 'alerts' => [{ 'labels' => { 'alertname' => 'HighCPU' }, 'state' => 'firing' }] } }]
      end
      result = client.list_alerts
      expect(result[:alerts]['status']).to eq('success')
      expect(result[:alerts]['data']['alerts']).to be_an(Array)
    end
  end

  describe '#list_rules' do
    it 'returns alerting rules' do
      stubs.get('/api/v1/rules') do
        [200, { 'Content-Type' => 'application/json' },
         { 'status' => 'success', 'data' => { 'groups' => [{ 'name' => 'example', 'rules' => [] }] } }]
      end
      result = client.list_rules
      expect(result[:rules]['status']).to eq('success')
      expect(result[:rules]['data']['groups']).to be_an(Array)
    end
  end
end
