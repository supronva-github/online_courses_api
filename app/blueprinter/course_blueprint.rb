class CourseBlueprint < Blueprinter::Base
  puts caller
  identifier :id
  fields :title
  association :competences, blueprint: CompetenceBlueprint
  association :author, blueprint: UserBlueprint
end
