class ReviewsController < ApplicationController
	before_action :authenticate_user!
	skip_before_filter :verify_authenticity_token, only: [:create]


	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id

		if @review.save
			render partial: "listings/listing_review"
		else
			render status: 422, json:{
				message: "Unable to create Review",
				errors: @review.errors
			}
		end

	end


	private

		def review_params
			params.require(:review).permit(:title, :comment, :rating, :listing_id)
		end

end