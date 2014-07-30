class CreateGeodbPlzLocs < ActiveRecord::Migration
  def change
    create_table :geodb_plz_locs do |t|
      t.integer :loc_id
      t.string :plz_7
      t.string :plz
      t.double :lat
      t.double :lon
      t.double :lat_bm
      t.double :lon_bm
      t.string :ort

      t.timestamps
    end
  end
end
