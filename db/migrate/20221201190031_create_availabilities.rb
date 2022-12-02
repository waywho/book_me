class CreateAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :availabilities, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :calendar, null: false, foreign_key: true, type: :uuid
      t.references :appointment_type, null: false, foreign_key: true, type: :uuid
      t.datetime :start_at
      t.datetime :end_at
      t.string :identification

      t.timestamps
    end
  end
end
