Class.new(Sequel::Migration) do
  def up
    create_table(:users) do
      primary_key :id
      String :login
      String :email
      String :encrypted_password
      Text :salt
    end
  end
end
