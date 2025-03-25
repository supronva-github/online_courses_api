# frozen_string_literal: true

namespace :db do
  desc 'Reset sequence for tables'
  task reset_sequences: :environment do
    %w[competences course_competences courses users].each do |table|
      ActiveRecord::Base.connection.execute(
        "SELECT SETVAL('public.#{table}_id_seq', COALESCE(MAX(id), 1)) FROM public.#{table};"
      )
      puts "Sequence for #{table} reset"
    rescue ActiveRecord::StatementInvalid => e
      puts "Error resetting sequence for #{table}: #{e.message}"
    end
  end
end
