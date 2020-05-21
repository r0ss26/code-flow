class ProfilesController < ApplicationController
  before_action :set_user

  def show
    # Get the rows from the educations and employments table
    # where the user id is that of the user passed in to the params.
    @educations = @user.educations
    @employments = @user.employments
    # Get the reviews from the reviews table where the review_receiver_id
    # is the same as the user id passed in to the params.
    @reviews = Review.where(review_receiver_id: @user.id)

    if !@reviews.empty?
      @avg_rating = @reviews.average(:rating).round(2) 
    end
  end

  private

  def set_user
    # Find the row in the user table where the user_id is the same as that
    # passed in to the params. Eager load the educations and employments
    # as these will be accessed in the erb templat.e
    @user = User.includes(:educations, :employments).find(params[:user_id])
  end
end