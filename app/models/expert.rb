class Expert < ActiveRecord::Base
   attr_accessible :firmenname, :anrede, :titel, :name, :vorname, :strasse, :hausnr, :plz_7, :plz, 
				:ort, :vorwahl, :telefon, :email, :website, :ausbildung, 
				:bafa, :kfw_bauen_und_sanieren, :energ_fachplanung, :baubegleitung, 
				:kfw_denkmal

   	before_save { |expert| expert.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
	
end
