
class StaticPagesController < ApplicationController
  
  def home
	store_request('')
  end

  def contact
	store_request('')
  end

  def impressum
	store_request('')
  end
  
  private
  
  	def store_request(req)
		session[:request] = req
	end
end
