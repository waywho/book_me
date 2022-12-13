class AddEndAtToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :end_at, :datetime
    change_column :events, :start_at, :datetime
  end
end
