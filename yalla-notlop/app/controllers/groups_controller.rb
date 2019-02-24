class GroupsController < ApplicationController
    before_action :get_user, only: [:show, :index]
    before_action :get_user_groups, only: [:show, :index]
    
    def index
        @group = Group.new
    end

    def show
        @this_group = @user.groups.find_by(id: params[:id])
        unless @this_group
            redirect_to groups_path
        end
        @members = @this_group.members.joins(:user).select(:name, :email, :user_id, :group_id)
        @group = Group.new
        @member = @this_group.members.build
    end

    def create
        @newgroup = current_user.groups.create(get_group_params)
        redirect_to groups_path
    end

    def destroy
        Group.find(params[:id]).destroy
        redirect_to groups_path
    end

    private
    def get_group_params
        params.require(:group).permit(:name)
    end
    def get_user
        @user = current_user
    end
    def get_user_groups
        @groups = @user.groups.all
    end
end
