# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PushNotificationsService do
  include PushNotificationsService
  before do
    @user = FactoryBot.create :user
    @subscription = FactoryBot.attributes_for :subscription
    @subscription.merge!(user_id: @user.id,
                         message: {
                           title: 'Testing',
                           body: 'Test'
                         })
  end

  describe 'when an exception occurs' do
    it 'should not throw an error if the webpush subscription is invalid' do
      # Webpush::InvalidSubscription requires an object, not a hash :(
      error = OpenStruct.new(body: 404)
      allow(Webpush).to receive(:payload_send).and_raise(
        Webpush::InvalidSubscription.new(error, 'body')
      )

      expect do
        response = send_webpush_notification(@user.id, @subscription)
        expect(response).to be(false)
      end.to_not raise_error
    end

    it 'should not error with no vapid keys' do
      ENV['VAPID_PUBLIC_KEY'] = ''
      ENV['VAPID_PRIVATE_KEY'] = ''

      expect do
        response = send_webpush_notification(@user.id, @subscription)
        expect(response).to be(false)
      end.to_not raise_error
    end
  end

  describe 'when there are no exceptions' do
    it 'should perform an analytics event successfully' do
      ENV['VAPID_PUBLIC_KEY'] = 'ADn'
      ENV['VAPID_PRIVATE_KEY'] = 'ADg'
      allow(Webpush).to receive(:payload_send)

      expect do
        response = send_webpush_notification(@user.id, @subscription)
        expect(response).to be(true)
      end.to_not raise_error

      expect(Webpush).to have_received(:payload_send).with(
        message: @message,
        endpoint: @endpoint,
        p256dh: @key,
        auth: @auth,
        vapid: {
          subject: 'mailto:plantiapp@gmail.com',
          public_key: ENV['VAPID_PUBLIC_KEY'],
          private_key: ENV['VAPID_PRIVATE_KEY']
        },
        ssl_timeout: 5,
        open_timeout: 5,
        read_timeout: 5
      )
    end
  end
end
