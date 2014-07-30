class ExpertsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :new, :update, :create, :destroy]
  
  # GET /experts
  # GET /experts.json
  def eausweis
	store_request('eausweis')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @experts }
    end
  end

  def eberatung
	store_request('eberatung')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @experts }
    end
  end
  
	
  # GET /show_experts_ea Suchergebnis Energieexperten
  def show_experts_ea
    @objart = params[:optobjektart]
	@postlz = params[:plz]
	@radius = params[:kmradius]
	
	musterplz = /^\d{5}$/
	respond_to do |format|
		if !@postlz.empty? && @postlz =~ musterplz
			# Lokationsdaten der eingebenen PLZ selektieren
			@plzloc = GeodbPlzLoc.where("plz = :plz", plz: @postlz)
			if !@plzloc.empty? 
				splz = @plzloc[0]
				@experts = Expert.find_by_sql( " SELECT ACOS(SIN(" + splz.lat_bm.to_s + ") * SIN(lat_bm) + " +
								"COS(" + splz.lat_bm.to_s + ") * COS(lat_bm) * COS(" + splz.lon_bm.to_s + " - lon_bm)) * 6380 " +
								"AS distance, experts.* FROM geodb_plz_locs , experts " + 
								"where geodb_plz_locs.plz_7 = experts.plz_7 " +
								"HAVING distance <='" + @radius + "'").paginate(:page => params[:page], :per_page => 8)
				
				#@experts = Expert.where("plz = :plz and objekt_art = :objektart", 
				#		plz: splz.plz, objektart: @objart)
				format.html # show_experts_ea.html.erb
				#format.csv { render text: @experts.to_csv }
				#format.json { render json: @expert }
			else
				flash.now[:warning] = "Die eingegebene PLZ wurde nicht gefunden!"
				format.html { render action: "eausweis" }
			end	
		else
			flash.now[:warning] = "Bitte eine 5-stellige PLZ eingeben!"
			format.html { render action: "eausweis" }
		end
	end
  end	
  
  
  # GET /experts
    def index
		store_request('experts')
		pager = session[:page] ||= params[:page]
		store_page pager
		sort = 'plz'
		@experts = Expert.find(:all, :order => sort).paginate(page: pager, per_page: 15)
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @experts }
		end
	end
	
  	def edit
		store_request('new_expert')
		read_last_page
		@expert = Expert.find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @experts }
		end
	end
	# 
	def new
		store_request('new_expert')
		@expert = Expert.new
		read_last_page
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @experts }
		end
	end

  # POST /experts
  # POST /experts.json
	def create
		@expert = Expert.new(params[:expert])
		@expert.created_by = current_user.email
		#read_last_page
		respond_to do |format|
		if @expert.save
			flash[:success] = 'Der Experte wurde gespeichert.'
			format.html { redirect_to experts_path }
			format.json { render json: @expert, status: :created, location: @expert }
		else
			format.html { render action: "new"}
			format.json { render json: @expert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /experts/1
  # PUT /experts/1.json
  def update
    @expert = Expert.find(params[:id])
	@expert.update_by = current_user.email
    respond_to do |format|
      if @expert.update_attributes(params[:expert])
		flash[:success] = 'Daten wurden gespeichert.'
        format.html { redirect_to experts_url }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experts/1
  # DELETE /experts/1.json
  def destroy
    read_last_page
	@expert = Expert.find(params[:id])
    @expert.destroy
	flash[:success] = 'Daten wurden geloescht!'
    respond_to do |format|
      format.html { redirect_to experts_url }
      format.json { head :no_content }
    end
  end
  
  private
  	
	def store_request(req)
		session[:request] = req
	end 
			
end
