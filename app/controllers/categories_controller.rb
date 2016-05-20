class CategoriesController < ApplicationController
	helper_method :listing_category

	def index
			#Kindly refactor this ===> Highly important
		if @category = Category.find_by_slug(params[:category])
			@listings = Listing.joins("join categories_listings on listings.id = categories_listings.listing_id").where(["categories_listings.category_id = ?", @category.id]).order(created_at: :asc)
			# byebug
		else
			flash[:notice] = "Can't find requested parameters"
			@listings = Listing.all()
		end
	end

	def listing_categories
		@category = Category.all()
	end

	private

		def choose_layout
			return 'category/'+ params[:category] if Category.pluck('slug').include?(params[:category])
			'application'
		end

		def listing_category
			# byebug
			return params[:category] unless params[:category].nil? or Category.find_by_slug(params[:category]).nil?
			"default"
		end

end