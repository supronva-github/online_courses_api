# frozen_string_literal: true

FactoryBot.define do
  factory :oauth_access_token, class: 'Doorkeeper::AccessToken' do
    application { association :oauth_application }
    resource_owner_id { create(:user).id }
    token { SecureRandom.hex(32) }
    expires_in { 2.hours.to_i }
    scopes { 'read write' }
    revoked_at { nil }

    trait :expired do
      expires_in { 0 }
    end
  end
end
