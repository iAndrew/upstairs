class InvolvementsController < ApplicationController

  before_filter :authenticate
  
  def new
    @group = Group.find(params[:group_id])
    @involvement = @group.involvements.new
    @involvement.user = current_user
    @involvement.start_date = Date.today
    @title = "Join a #{@group.name}"
    @roles = Role.all
  end

  def create
    @group = Group.find(params[:involvement][:group_id])
    @title = "Join a #{@group.name}"
    @involvement = @group.involvements.new(params[:involvement].merge(:edited_by => current_user.nickname))
    @role = Role.find(params[:involvement][:role_id])
    
    if current_user.id == params[:involvement][:user_id].to_i
      if @involvement.save
        flash[:success] = "You have joined to group '#{@group.name}' as #{@involvement.status} #{@role.name}"
        redirect_to group_path(@group)
      else
        @roles = Role.all
        render :new, :group_id => params[:group_id]
      end
    else
      @roles = Role.all
      render :new, :group_id => params[:group_id]
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
