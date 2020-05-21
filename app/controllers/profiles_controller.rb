class ProfilesController < ApplicationController
  before_action :set_user

  def show
    # Get the users educations, employments and received reviews.
    @educations = @user.educations
    @employments = @user.employments
    @reviews = Review.where(review_receiver_id: @user.id)

    if !@reviews.empty?
      @avg_rating = @reviews.average(:rating).round(2) 
    end
  end

  private

  def set_user
    @user = User.includes(:educations, :employments).find(params[:user_id])
  end
end