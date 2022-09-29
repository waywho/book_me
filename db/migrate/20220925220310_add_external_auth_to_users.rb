class AddExternalAuthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :provider, :string, default: nil
    add_column :users, :uid, :string, default: nil
  end
end
