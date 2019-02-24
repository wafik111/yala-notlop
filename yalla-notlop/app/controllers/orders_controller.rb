class OrdersController < ApplicationController
    before_action :get_user, only: [:index, :new, :create, :destroy, :edit, :update]

    #GET /orders
    def index
        @orders = @user.orders
    end

    def new
        @order = @user.orders.build
    end

    #POST /orders
    def create
        @order = @user.orders.build(get_order_params)
        @order.status = :waiting
        unless @order.save or @order.ends_at > Time.now
            redirect_to new_order_path and return
        end
        @invited_peoples = params[:order][:invited_ids].split(",")
        @invited_peoples.each do |invited|
            unless @order.invited_members.find_by(user_id: invited)
                @order.invited_members.create(user_id: invited)
                @order.order_notifications.create(from: @user, to_id: invited, status: :unread)
            end
        end
        redirect_to order_path @order
    end

    def edit
        @order = @user.orders.find_by(id: params[:id])
    end

    def update
        @order = @user.orders.find_by(id: params[:id])
        if get_order_params[:ends_at] >= Time.now
            redirect_to edit_order_path and return
        end
        @order.update(get_order_params) if @order.waiting?
        @invited_peoples = params[:order][:invited_ids].split(",")
        @invited_peoples.each do |invited|
            @order.invited_members.create(user_id: invited)
        end
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

    #DELETE /order/:id
    def destroy
        @order = @user.orders.find_by(id: params[:id])
        @order.destroy if @order
        redirect_to orders_path and return
    end

    private
    def get_user
        @user = current_user
    end

    def get_order_params
        params.require(:order).permit(:name, :menu, :resturant, :meal, :ends_at)
    end
end
