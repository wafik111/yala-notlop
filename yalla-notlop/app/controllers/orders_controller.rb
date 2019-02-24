class OrdersController < ApplicationController
    before_action :get_user, only: [:index, :new, :create]

    #GET /orders
    def index
        @orders = @user.orders
    end

    def new
        @order = @user.orders.build
    end

    def create
        @order = @user.orders.build(get_order_params)
        @order.status = :waiting
        unless @order.save
            redirect_to new_order_path
        end
        @invited_peoples = get_initations[:invitations].split(",")
        @invited_peoples.each do |invited|
            p "=========="
            p invited
            @order.invited_members.create(invited)
        end
        p get_order_params
        p @order.id
        redirect_to order_path @order
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

    def get_order_params
        params.require(:order).permit(:name, :menu, :resturant, :meal, :ends_at)
    end
    def get_initations
        params.require(:order).permit(:invitations)
    end
end
