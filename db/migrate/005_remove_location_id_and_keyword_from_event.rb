class RemoveLocationIdAndKeywordFromEvent < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :location_id, :integer
    remove_column :events, :keyword, :text
  end
end
