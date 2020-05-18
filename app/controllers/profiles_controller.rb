class ProfilesController < ApplicationController

  def show
    @education_history = Education.all
    @employment_history = Employment.all
    @reviews = Review.where(review_receiver_id: current_user.id)
    @listings = current_user.listings
  end

  def education

  end

  def employment

  end

  def listings

  end

  def reviews

  end

end