class PagesController < ApplicationController

  def home
    # @popular_listings = Order.select(:listing_id).group(:listing_id).order("count(listing_id) DESC").limit(10)
  end
  
end