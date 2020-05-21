class PagesController < ApplicationController

  def home
    # Get the top 5 listings which have been ordered the most.
    @popular_listings = Listing.order("orders_count DESC").limit(5)
    # Get the tags which have been used the most.
    @tags = ActsAsTaggableOn::Tag.most_used(10)
  end
  
end