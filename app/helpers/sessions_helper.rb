module SessionsHelper
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		current_user = user
	end
	def cur_page(page)
		current_page = page
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end
	
	def sign_out
		current_user = nil
		cookies.delete(:remember_token)
	end
	
	def signed_in_user
		if !signed_in?
			flash[:danger] = 'Bitte anmelden!' 
			redirect_to login_path
		end
	end
		
	def store_page(pg) 
		session[:last_page] = pg
		session[:page] = nil
	end
	
	def read_last_page
		session[:page] = session[:last_page]
	end
end
