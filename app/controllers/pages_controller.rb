class PagesController < ApplicationController

  def home
    @popular_listings = Listing.order("orders_count DESC").limit(5)
    @tags = ActsAsTaggableOn::Tag.most_used(10)
  end
  
end