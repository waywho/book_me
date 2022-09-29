class AddExternalAuthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :provider, :string, default: nil
  end
end
