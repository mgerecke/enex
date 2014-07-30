class AddIndexToExperts < ActiveRecord::Migration
  def change
	add_index :experts, :plz_7
	add_index :experts, :email, unique: true
  end
end
