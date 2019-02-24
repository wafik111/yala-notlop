class WelcomeController < ApplicationController
  def index
    @user = current_user
    @orders = @user.orders.all
    #TODO: GET FRIEND'S ORDERS
    #@friends = @user.friends.joins(:orders)
  end
end
