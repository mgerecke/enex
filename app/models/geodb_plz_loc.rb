class GeodbPlzLoc < ActiveRecord::Base
  attr_accessible :lat, :lat_bm, :loc_id, :lon, :lon_bm, :ort, :plz, :plz_7
end
