class AddExternalIdentifierToCalendars < ActiveRecord::Migration[7.0]
  def change
    add_column :calendars, :external_identifier, :string, unique: true
  end
end
