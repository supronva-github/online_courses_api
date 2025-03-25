# frozen_string_literal: true

namespace :db do
  desc 'Reset sequence for tables'
  task reset_sequences: :environment do
    ActiveRecord::Base.connection.execute(
      'TRUNCATE TABLE competences, course_competences, courses, users RESTART IDENTITY CASCADE'
    )
    puts 'Sequence for tables reset'
  end
end
