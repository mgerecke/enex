class CreateExperts < ActiveRecord::Migration
  def change
    create_table :experts do |t|
      t.string :firmenname
	  t.string :anrede
	  t.string :titel
	  t.string :vorname
	  t.string :name
	  t.string :strasse
	  t.string :hausnr
      t.string :plz_7
	  t.string :plz
      t.string :ort
	  t.string :vorwahl
	  t.string :telefon
	  t.string :email, null: false
	  t.string :website
	  t.string :ausbildung
	  t.boolean :bafa, null: false, default: false
	  t.boolean :kfw_bauen_und_sanieren, null: false, default: false
	  t.boolean :energ_fachplanung,  null: false, default: false
	  t.boolean :baubegleitung, null: false, default: false
	  t.boolean :kfw_denkmal, null: false, default: false
	  t.string :created_by
	  t.string :update_by
      t.timestamps
    end
  end
end
