class ChangeExternalIdentifierToCalendars < ActiveRecord::Migration[7.0]
  def up
    change_column :calendars, :external_identifier, :string, null: false
  end

  def down
    change_column :calendars, :external_identifier, :string, null: true
  end
end
