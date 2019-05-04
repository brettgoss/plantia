# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoogleAnalyticsService do
  before do
    @params = %w[testing test 12345]
  end

  describe 'when an exception occurs' do
    it 'should not impact production if Redis is down' do
      allow(AnalyticsWorker).to receive(:perform_async).and_raise(Redis::CannotConnectError)

      expect do
        response = GoogleAnalyticsService.call(*@params)
        expect(response).to be(false)
      end.to_not raise_error
    end

    it 'should not impact production if GoogleAnalytics is down' do
      allow(AnalyticsWorker).to receive(:perform_async).and_raise(HTTP::Error)

      expect do
        response = GoogleAnalyticsService.call(*@params)
        expect(response).to be(false)
      end.to_not raise_error
    end

    it 'should not do anything with no analytics ID' do
      ENV['GA_TRACKING_ID'] = ''

      expect do
        response = GoogleAnalyticsService.call(*@params)
        expect(response).to be(false)
      end.to_not raise_error
    end
  end

  describe 'when there are no exceptions' do
    it 'should perform an analytics event successfully' do
      ENV['GA_TRACKING_ID'] = 'UA-12345'
      allow(AnalyticsWorker).to receive(:perform_async)

      expect do
        response = GoogleAnalyticsService.call(*@params)
        expect(response).to be(true)
      end.to_not raise_error

      expect(AnalyticsWorker).to have_received(:perform_async).with(
        cid: '12345',
        ea: 'test',
        ec: 'testing',
        t: 'event',
        tid: ENV['GA_TRACKING_ID'],
        v: 1
      )
    end
  end
end
