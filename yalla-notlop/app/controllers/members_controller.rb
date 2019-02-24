class MembersController < ApplicationController
    before_action :get_user, only: [:index, :create, :destroy]
    before_action :get_user_group, only: [:index, :create, :destroy]
    skip_before_action :verify_authenticity_token

    def index
        unless @group
            render :json => [].to_json
        else
            @members = @group.members.joins(:user).select(:user_id, :name, :email)
            render :json => @members.to_json(only: [:user_id, :name, :email])
        end
    end

    def create
        #TODO check if the meber is a friend
        unless @group
            redirect_to groups_path and return
        end
        @user_member = User.find_by(name: get_member_params["name"])
        unless @user_member
            redirect_to group_path @group.id and return
        end
        unless @group.members.exists?(user_id: @user_member)
            @member = @group.members.create(user: @user_member)
        end
        redirect_to group_path @group.id and return

    end

    def destroy
        unless @group
            redirect_to groups_path
        end
        p @group
        @member = @group.members.find_by(user_id: params[:id])
        unless @member
            redirect_to group_path params[:group_id]
        end
        @member.delete
        redirect_to group_path params[:group_id]
    end

    private
    def get_member_params
        params.require(:member).permit(:name)
    end

    def get_user
        @user = current_user
    end

    def get_user_group
        @group = @user.groups.find_by(id: params[:group_id])
    end
end
