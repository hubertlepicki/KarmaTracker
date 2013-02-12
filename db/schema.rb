Sequel.migration do
  change do
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:users) do
      primary_key :id
      column :email, "text", :null=>false
      column :api_token, "text", :null=>false
      column :name, "text", :null=>false
    end
  end
end
