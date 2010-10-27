class GroupsController < ApplicationController
  
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
    flash[:success] = "Group removed"
    redirect_to groups_path
  end
  
  def 

end
