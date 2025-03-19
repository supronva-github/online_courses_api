# frozen_string_literal: true

class CreateCompetences < ActiveRecord::Migration[6.1]
  def change
    create_table :competences do |t|
      t.string :name

      t.timestamps
    end

    add_index :competences, :name, unique: true
  end
end
