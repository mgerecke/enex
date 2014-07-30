class SessionsController < ApplicationController
	def new
		store_request('login')
	end
	
	def create
		@user = User.find_by_email(params[:session][:email])
		if @user && @user.authenticate(params[:session][:password])
			store_request('')
			sign_in @user
			flash[:success] = "Willkommen!"
			redirect_to @user
		else
			flash.now[:danger] = 'Die Email/Passwort-Kombination ist unbekannt!'
			render 'new'
		end
	end
	
	def destroy
		sign_out
		flash[:success] = 'Sie wurden erfolgreich abgemeldet. Auf Wiedersehen!'
		redirect_to root_path
	end
	
	private
  	
	def store_request(req)
		session[:request] = req
	end 
	
end
