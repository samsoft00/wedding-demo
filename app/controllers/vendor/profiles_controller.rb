class Vendor::ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  before_action :authenticate_user!, except: [:show]
  before_action :check_profile, only: [:create]

  # GET /profiles
  # GET /profiles.json
  # def index
  #   @profiles = Profile.all
  # end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @user = User.find_by_username(params[:username])
    if !@user.nil?
      @profile = @user.profile
    else
      redirect_to vendor_root_path
    end

    # byebug
  end

  # GET /profiles/new
  def new
    # if current_user.profile.nil?
      @profile = current_user.profile || Profile.new
    # else

      if current_user
        #redirect_to edit_vendor_profile_path(current_user.profile.id)
      end
      #else
        #redirect to update
      #redirect_to vendor_path(current_user.username)
      #end
      
    # end
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = current_user.profile || Profile.new
    @profile.user_id = current_user.id
    @profile.status = :start
    @profile.save(validate: false)
    session[:profile_id] = @profile.id
    redirect_to vendor_setup_store_index_path
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      # byebug
      if @profile.update(profile_params)
        format.html { redirect_to vendor_path(current_user.username), notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name, :business_name, :about, :phone, :website, :category_id, :facebook, :twitter, :instagram, :address, :city, :state, :country, :profile_image)
    end
 
    def check_profile
      if current_user.profile.present? and current_user.profile.status != 'active'
        session[:profile_id] = current_user.profile.id
        redirect_to vendor_setup_store_path(current_user.profile.status.to_sym)
      end
    end
    
end