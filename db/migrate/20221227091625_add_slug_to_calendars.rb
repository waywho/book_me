class AddSlugToCalendars < ActiveRecord::Migration[7.0]
  def change
    add_column :calendars, :slug, :string
    add_index :calendars, :slug, unique: true
  end
end
