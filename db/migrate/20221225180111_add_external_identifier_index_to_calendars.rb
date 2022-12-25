class AddExternalIdentifierIndexToCalendars < ActiveRecord::Migration[7.0]
  def change
    add_index :calendars, :external_identifier
  end
end
