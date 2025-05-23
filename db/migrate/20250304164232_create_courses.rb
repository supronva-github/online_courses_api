# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.text :description
      t.references :author, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
