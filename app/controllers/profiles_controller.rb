class ProfilesController < ApplicationController

  def show
    # @education_history = Education.all
    # @employment_history = Employment.all
    @user = User.find(params[:user_id])
    @reviews = Review.where(review_receiver_id: params[:user_id])
    puts @reviews
    if !@reviews.empty?
      @avg_rating = @reviews.average(:rating).round(2) 
    end
    @listings = User.find(params[:user_id]).listings
  end

  def education
    @educations = User.find(params[:user_id]).educations
  end

  def employment
    @employments = User.find(params[:user_id]).employments
  end

  def listings
    @listings = User.find(params[:user_id]).listings
  end

  def reviews
    @reviews = Review.where(review_receiver_id: params[:user_id])
  end

end