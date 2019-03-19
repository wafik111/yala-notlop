class WelcomeController < ApplicationController
  def index
    @user = current_user
    @orders = @user.orders.order(created_at: :desc)
    @friends_activities = Order.where(user_id: @user.friends.select(:id)).joins(:user).select("orders.*, users.name as username").order(created_at: :desc)
  end
end
