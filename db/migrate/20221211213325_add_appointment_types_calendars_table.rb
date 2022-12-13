class AddAppointmentTypesCalendarsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :appointment_types_calendars, id: false do |t|
      t.references :appointment_type, null: false, foreign_key: true, type: :uuid
      t.references :calendar, null: false, foreign_key: true, type: :uuid
    end
  end
end
