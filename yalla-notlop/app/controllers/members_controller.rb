class MembersController < ApplicationController
    before_action :get_user, only: [:index, :create, :destroy]
    before_action :get_user_group, only: [:index, :create, :destroy]
    skip_before_action :verify_authenticity_token

    def index
        (render :json => [].to_json and return) unless @group
        render :json => @group.members.user.to_json(only: [:id, :name, :email])
    end

    def create
        <<-comment
        redirect to groups index if the specified group deosn't exit for the user
        else we search for the requested member if is a friend or the current user or not.
        if not we return the the show view of the group, else we create a new member to the group
        if the member is not already a member in the group then redirect to the group show view
        comment

        (redirect_to groups_path and return) unless @group 
        @user_member = @user.friends.find_by(name: get_member_params["name"]
        (redirect_to group_path @group.id and return) unless @user_member
        @member = @group.members.create(user: @user_member) unless @group.members.exists?(user_id: @user_member)
        redirect_to group_path @group.id and return

    end

    def destroy
        (redirect_to groups_path and return) unless @group
        @member = @group.members.find_by(user_id: params[:id])
        (redirect_to group_path params[:group_id] and return) unless @member
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
