class PagesController < ApplicationController

  def home
    @popular_listings = Listing.order("orders_count DESC").limit(5)
  end
  
end