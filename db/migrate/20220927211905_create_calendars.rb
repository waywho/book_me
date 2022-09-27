class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :identifier
      t.string :time_zone
      t.string :summary
      t.string :description
      t.boolean :primary
      t.string :service
      t.string :etag

      t.timestamps
    end
  end
end
