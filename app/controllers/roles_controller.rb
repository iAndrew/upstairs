class RolesController < ApplicationController
  
  def index
    @roles = Role.all
    @title = "Roles"
  end
  
  def new
    @role = Role.new();
    @title = "Create a new role"
  end
  
  def create
    @role = Role.new(params[:role])
    if @role.save
       flash[:success] = "New role '#{@role.name}' was created."
       redirect_to roles_path
    else
       @title = "Create a new role"
       render 'new'
    end    
  end
  
  def destroy
    Role.find_by_id(params[:id]).destroy
    render 'index'
  end

end
