class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def buyer

  end

  def seller

  end

  def purchases
    @purchases = Order.where(buyer_id: current_user.id)
    @current_purchases = @purchases.where(completed: false)
    @past_purchases = @purchases.where(completed: true)
  end

  def favorites
    @favorites = current_user.favorited_by_type('Listing')
  end

  def listings
    @listings = Listing.where(user: current_user)
    @active_listings = @listings.where(active: true)
    @inactive_listings = @listings.where(active: false)
  end

  def sales
    @orders = Order.where(seller_id: current_user.id)
    @active_orders = @orders.where(completed: false)
    @past_orders = @orders.where(completed: true)
  end

  def reviews
    @reviews = Review.where(review_receiver_id: current_user.id)
  end

end