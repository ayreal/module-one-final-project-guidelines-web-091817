class CreateEvent < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string  :name
      t.integer :location_id
      t.string  :date
      t.text    :description
	    t.text    :keyword
    end
  end
end
