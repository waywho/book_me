class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :location
      t.references :calendar, null: false, foreign_key: true, type: :uuid
      t.date :start_at
      t.string :type
      t.string :creator_name
      t.string :creator_email
      t.string :etag
      t.string :identifier
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :appointment_type, null: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
