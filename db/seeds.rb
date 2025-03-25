# frozen_string_literal: true

Rake::Task['db:reset_sequences'].invoke

Doorkeeper::Application.create!(
  name: 'Test App',
  uid: SecureRandom.uuid,
  secret: SecureRandom.hex(32),
  redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
  scopes: 'read write'
)

%w[Ruby Docker RoR Git RSpec PostgreSQL Redis Kafka].map do |name|
  Competence.find_or_create_by!(name: name)
end

3.times do |_i|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password_digest: BCrypt::Password.create('password'),
    role: 'user'
  )
end

Doorkeeper::AccessToken.create!(
  application: Doorkeeper::Application.first,
  resource_owner_id: User.first.id,
  token: SecureRandom.hex(32),
  expires_in: 2.hours.to_i,
  scopes: 'read write',
  revoked_at: nil
)

authors = User.all
competences = Competence.all

10.times do |_i|
  Course.create!(
    title: Faker::Educator.course_name,
    author: authors.sample,
    competences: competences.sample(rand(1..3))
  )
end
