class UsersController < ApplicationController
	before_filter :signed_in_user
	
	def show
		store_request('')
		@user = User.find(params[:id])
	end
  
	def new
		@user = User.new
	end
  	
	def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
		flash[:success] = "Der Anwender wurde gespeichert!"
        format.html { redirect_to @user }
        format.json { render json: @expert, status: :created, location: @expert }
      else
        format.html { render action: "new" , notice: 'Angaben pruefen'  }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
	
	private
	def store_request(req)
		session[:request] = req
	end 
end
