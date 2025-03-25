# frozen_string_literal: true

FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name { 'Test App' }
    uid { SecureRandom.uuid }
    secret { SecureRandom.hex(32) }
    redirect_uri { 'urn:ietf:wg:oauth:2.0:oob' }
    scopes { 'read write' }
  end
end
