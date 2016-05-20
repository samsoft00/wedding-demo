class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index, :show]
  before_action :validate_username, only: [:new, :index]
  before_action :check_if_profile_created, only: [:new]
  helper_method :check_if_image_exist?
 
  # GET /listings
  # GET /listings.json
  def index
    @listings = current_user.listing.all
    # byebug
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @review = Review.new

    if @listing.reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @listing.reviews.average(:rating).round(2)
    end

  end

  # GET /listings/new
  def new
    @listing = Listing.new
    2.times { @listing.faq.build } if @listing.new_record?
    3.times { @listing.pictures.build } if @listing.new_record?
  end

  # GET /listings/1/edit
  def edit
    # 2.times {@listing.listing_image.build}
  end

  # POST /listings
  # POST /listings.json 
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    @listing.profile_id = current_user.profile.id
    @listing.status = params[:status].nil? ? 'pending' : 'draft'

    respond_to do |format|
      if @listing.save
        @listing.category_ids=(params[:category]) unless params[:category].empty? or params[:category].nil?
        format.html { redirect_to display_vendor_listing(current_user.username, @listing), notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        @listing.category_ids=(params[:category]) unless params[:category].empty? or params[:category].nil?
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_images
    @image = ListingImage.find(params[:id])
    @image.destroy
    redirect_to(:back)
  end

  def check_if_image_exist?(object)
    !object.listing_image.blank?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :details, :status, :short_description, :slug, :pricing_and_faq, faq_attributes: [:id, :key, :value, :_destroy], pictures_attributes: [:id,:image, :image_id, :image_cache_id, :description,:_destroy])
    end

    def validate_username
      if params[:username].present? && current_user.username != params[:username]
        redirect_to :action => :index, :username => current_user.username
      end
    end


end
