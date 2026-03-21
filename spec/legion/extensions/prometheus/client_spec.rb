# frozen_string_literal: true

RSpec.describe Legion::Extensions::Prometheus::Client do
  subject(:client) do
    described_class.new(
      url:      'http://prometheus:9090',
      username: 'admin',
      password: 'secret'
    )
  end

  describe '#initialize' do
    it 'stores url in opts' do
      expect(client.opts[:url]).to eq('http://prometheus:9090')
    end

    it 'stores username in opts' do
      expect(client.opts[:username]).to eq('admin')
    end

    it 'stores password in opts' do
      expect(client.opts[:password]).to eq('secret')
    end
  end

  describe '#settings' do
    it 'returns a hash with options key' do
      expect(client.settings).to eq({ options: client.opts })
    end
  end

  describe '#connection' do
    it 'returns a Faraday connection' do
      expect(client.connection).to be_a(Faraday::Connection)
    end
  end
end
