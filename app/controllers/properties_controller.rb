class PropertiesController < ApplicationController

  
  
  # GET /properties
  # GET /properties.json
  def index
    session[:mainnav_status] = true

    # @properties = Property.all
    
    @flex_mls_link = Property.new
    @properties = Property.find_by_realtor("20140811175233962697000000",4)
    #   puts(@flex_mls_link.find_by_realtor("20140811175233962697000000",4))
    @meta_lookup = @flex_mls_link.meta_lookup
    @full_lookup =  @flex_mls_link.full_lookup
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @properties} 
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    # @property = Property.find(params[:id])
    @properties = []

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @property }
    end
  end

  # GET /properties/new
  # GET /properties/new.json
  def new
    @property = Property.new
    @property = ""

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @property}
    end
  end

  # GET /properties/1/edit
  def edit
    session[:mainnav_status] = true

    @property = ""
   
  end

  # POST /properties
  # POST /properties.json
  def create
    #  @property = Property.new(property_params)
    @property = ""
    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: "Property was successfully created." }
        format.json { render json: @property, status: :created, location: @property }
      else
        format.html { render action: "new" }
        format.json { render json: @property.errors, status: :unprocessable_entry }
      end
    end
  end

  # PUT /properties/1
  # PUT /properties/1.json
  def update
    preferences_update = false
    
    if params[:id] == "property_preferences" then
      eval("Settings." + params["settings"].to_a.first[0] + "=\"" + (params["settings"].to_a.first[1]).html_safe() +"\""   )
      preferences_update = true
    else
      @property  = ""
      #  @property = Property.find(params[:id])
      #  successfull = @property.update_attributes(property_params)
    end
    
    respond_to do |format|
      if preferences_update then
        format.html {render nothing: true}
        format.json { render :json=> {:notice => 'Preferences were successfully updated.'} }
      
      else
        if successfull then
          format.html { redirect_to action: "edit", notice: "Property was successfully updated."}
          format.json { render :json=> {:notice => 'Property was successfully updated.'} }
        else
          format.html { render action: "edit" }
          format.json { render json: @property.errors, status: "unprocessable_entry" }
        end
      end
    end
  end
    
  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    # @property = Property.find(params[:id])
    # @property.destroy
    

    respond_to do |format|
      format.html { redirect_to properties_url }
      format.json { head :ok }
    end
  end
  
  # CREATE_EMPTY_RECORD /properties/1
  # CREATE_EMPTY_RECORD /properties/1.json

  def create_empty_record
    #  @property = Property.new
    #  @property.property_name="New Property"
    #  @property.property_description = "Edit Me."
    #  @property.unit_price = 0
    #  @property.msrp = 0
    # @property.save
    @property=""
    redirect_to(controller: :properties, action: :edit, id: @property)
  end
  
  def get_image
    url = params[:url]
    data = open(url).read
    send_data data, :disposition => 'inline', :type => 'image/jpg'
  end
  
  def show_image
    
    send_data @user.avatar_image, :type => 'image/png',:disposition => 'inline'
    
  end
end
