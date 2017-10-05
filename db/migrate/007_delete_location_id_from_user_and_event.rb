class DeleteLocationIdFromUserAndEvent < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :location_id, :integer
    remove_column :users, :location_id, :integer
  end
end
