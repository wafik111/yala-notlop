class OrdersController < ApplicationController
    before_action :get_user, only: [:index]

    #GET /orders
    def index
        @orders = @user.orders
    end

    #GET /orders/:id
    def show
        @order = Order.find_by(id: params[:id])
        if @order.ends_at <= Time.now
            @order.finished!
        end
        @order_informations = @order.order_informations.all
    end

    private
    def get_user
        @user = current_user
    end
end
