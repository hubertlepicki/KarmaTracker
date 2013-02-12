Sequel.migration do
  up do
    create_table :users do
      primary_key :id
      String :email, null: false
      String :api_token, null: false
      String :name, null: false
    end
  end

  down do
    drop_table :users
  end
end
