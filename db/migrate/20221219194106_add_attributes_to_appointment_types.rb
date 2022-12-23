class AddAttributesToAppointmentTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :appointment_types, :availability_identifier, :string
    add_column :appointment_types, :indefinite_booking, :boolean
    add_column :appointment_types, :days_ahead_booking, :integer
    add_column :appointment_types, :pause, :boolean
  end
end
