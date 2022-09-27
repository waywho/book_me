class AddExternalAuthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :external_auth, :string, default: nil
  end
end
