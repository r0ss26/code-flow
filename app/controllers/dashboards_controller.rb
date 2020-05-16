class DashboardsController < ApplicationController

  def buyer

  end

  def seller

  end

  def purchases
    @purchases = Order.where(buyer_id: current_user.id)
  end

  def favourites

  end

  def listings
    @listings = Listing.where(user: current_user)
    @active_listings = @listings.where(active: true)
    @inactive_listings = @listings.where(active: false)
  end

  def orders

  end

  def reviews

  end

end