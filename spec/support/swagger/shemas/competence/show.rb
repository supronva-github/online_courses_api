RSpec.shared_examples "competence_show_schema" do
  schema type: :object,
         properties: {
           data: {
             type: :object,
             properties: {
               id: { type: :integer },
               name: { type: :string }
             },
             required: %w[id name]
           }
         },
         required: %w[data]
end
