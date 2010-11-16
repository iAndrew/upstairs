class InvolvementsController < ApplicationController

  before_filter :authenticate
  
  def new
    @group = Group.find(params[:group_id])
    @involvement = @group.involvements.new
    @title = "Join a #{@group.name}"
  end

  def create
    if current_user.id == params[:involvement][:user_id]
      @group = Group.find(params[:group_id])
      @involvement = @group.involvements.new(params[:involvement])
      @role = Role.find(params[:involvement][:role_id])
      if @involvement.save
         flash[:success] = "You have joined to group '#{@group.name}' as #{@involvement.status} #{@role.name}"
         redirect_to group_path(@group)
      else
         @title = "Join a #{@group.name}"
         render :new #, :group_id => params[:group_id]
      end
    else
      render :new #, :group_id => params[:group_id]
    end
  end
  
  def destroy
    @involvement = Involvement.find(params[:id])
    @group = @involvement.group
    
    if current_user.id == @involvement.user_id 
      @involvement.destroy
      flash[:success] = "Involvement was removed"
    else 
      flash[:error] = "You're not allowed to remove this involvement"    
    end
    redirect_to group_path(@group)
  end

end
