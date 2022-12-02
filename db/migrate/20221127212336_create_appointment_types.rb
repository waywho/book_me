class CreateAppointmentTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :appointment_types, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :location
      t.integer :duration
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
