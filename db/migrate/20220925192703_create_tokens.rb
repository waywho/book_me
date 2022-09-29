class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens, id: :uuid do |t|
      t.text :token
      t.string :refresh_token
      t.datetime :expires_at
      t.string :provider
      t.references :user, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
