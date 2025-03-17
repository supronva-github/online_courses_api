RSpec.shared_examples "competences_index_schema" do
  schema type: :object,
         properties: {
           data: {
             type: :array,
             items: {
               type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               },
               required: %w[id name]
             }
           }
         },
         required: %w[data]
end
