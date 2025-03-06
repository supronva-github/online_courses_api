class CreateCourseCompetences < ActiveRecord::Migration[6.1]
  def change
    create_table :course_competences do |t|
      t.references :course, null: false, foreign_key: true
      t.references :competence, null: false, foreign_key: true

      t.timestamps
    end
  end
end
