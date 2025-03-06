# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

competences = %w[Ruby Docker RoR Git RSpec PostgreSQL Redis Kafka].map do |name|
  Competence.create!(name: name)
end

3.times do |i|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password_digest: BCrypt::Password.create("password#{i}"),
    role: "user"
  )
end

authors = User.all
competences = Competence.all

10.times do |i|
  Course.create!(
    title: Faker::Educator.course_name,
    author: authors.sample,
    competences: competences.sample(rand(1..3))
  )
end
