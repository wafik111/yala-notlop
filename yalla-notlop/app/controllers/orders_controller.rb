class OrdersController < ApplicationController
    before_action :get_user, except: [:show]

    #GET /orders
    def index
        @orders = @user.orders.order(created_at: :desc)
    end

    #GET /orders/new
    def new
        @order = @user.orders.build
    end

    #POST /orders
    def create
        @order = @user.orders.build(get_order_params)
        @order.status = :waiting
        #check if submitted data are valid.
        (render "new" and return) unless @order.save
        make_invitations()
        redirect_to order_path @order
    end

    #GET orders/:id/edit
    def edit
        @order = @user.orders.find_by(id: params[:id])
        #redirect to orders index if not an exited order or the order is not still waiting
        (redirect_to orders_path and return) if (@order == nil or not @order.waiting?)
        @invited_members = @order.invited_members.joins(:user).select("users.*")
    end

    #PUT /orders/:id
    def update
        @order = @user.orders.find_by(id: params[:id])
        (render "edit" and return) if get_order_params[:ends_at] >= DateTime.now
        @order.update(get_order_params) if @order.waiting?
        make_invitations()
        redirect_to order_path @order

    end

    #GET /orders/:id
    def show
        @order = Order.find_by(id: params[:id])
        (redirect_to orders_path and return) unless @order
        @order.finished! if @order.ends_at <= DateTime.now
        @order_informations = @order.order_informations.all
    end

    #DELETE /order/:id
    def destroy
        @order = @user.orders.find_by(id: params[:id])
        @order.cancelled! if @order
        redirect_to orders_path and return
    end

    private
    def get_user
        @user = current_user
    end

    def get_order_params
        params.require(:order).permit(:name, :menu, :resturant, :meal, :ends_at)
    end
    
    def make_invitations
        @invited_people = params[:order][:invited_ids].split(",").uniq
        @invited_ids = []
        @order.invited_members.select(:user_id).each {|r| @invited_ids.push(r.user_id.to_s)}
        @invited_people.each do |invited_id|
            unless @invited_ids.include?(invited_id)
                @order.invited_members.create(user_id: invited_id)
                @order.order_notifications.create(from: @user, to_id: invited_id, status: :unread)
            end
        end
    end

end
