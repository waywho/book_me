class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.text :token
      t.string :refresh_token
      t.datetime :expires_at
      t.string :service
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
