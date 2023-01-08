class AddSlugToAppointmentTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :appointment_types, :slug, :string
    add_index :appointment_types, :slug, unique: true
  end
end
