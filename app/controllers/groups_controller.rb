class GroupsController < ApplicationController
  
  before_filter :authenticate, :except => [:index]
  
  def new
    @group = Group.new
    @title = "Create a new group"
  end
  
  def index
    @groups = Group.all
    @title = "All groups"
  end

  def show
    @group = Group.find(params[:id])
    @title = "View group '#{@group.name}'."
    @involvements = @group.involvements.includes(:role, :user)
    @roles = Role.all
    @involvement = @group.involvements.new({:user_id => current_user.id, 
                                            :start_date => Date.today})
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
       flash[:success] = "New group '#{@group.name}' was created."
       redirect_to group_path(@group)
    else
       @title = "Create a new group"
       render 'new'
    end
  end
  
  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = "Group was removed"
    redirect_to groups_path
  end
  
  def edit
    @group = Group.find(params[:id])
    @title = "Edit #{@group.group_type.capitalize} #{@group.name}"
  end 
  
  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:success] = "Profile was updated."
      redirect_to group_path(@group)
    else
      @title = "Edit user"
      render 'edit'
    end
  end

#  def avatar_cropping
#   @title = "Group avatar cropping"
#   @group = Group.find(params[:id])
#   unless @group.avatar.exists?
#     redirect_to edit_group_url(@user)
#   end
#  end
end
