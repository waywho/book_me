class CreateCalendarAppointmentTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :calendar_appointment_types, id: :uuid do |t|
      t.references :calendar, null: false, foreign_key: true, type: :uuid
      t.references :appointment_type, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
