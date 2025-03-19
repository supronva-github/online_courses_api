class CourseBlueprint < Blueprinter::Base
  identifier :id
  fields :title
  association :competences, blueprint: CompetenceBlueprint
  association :author, blueprint: UserBlueprint
end
