class RolesController < ApplicationController
  
  def new
    @role = Role.new();
    @title = "Create a new role"
  end
  
  def create
    @role = Role.new(params[:role])
    if @role.save
       flash[:success] = "New role '#{@role.name}' was created."
       redirect_to role_path
    else
       @title = "Create a new group"
       render 'new'
    end    
  end

end
