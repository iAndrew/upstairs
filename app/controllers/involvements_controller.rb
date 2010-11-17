class InvolvementsController < ApplicationController

  before_filter :authenticate
  
  def new
    @group = Group.find(params[:group_id])
    @involvement = @group.involvements.new({:user_id => current_user.id, 
                                            :start_date => Date.today})
    @title = "Join a #{@group.name}"
    @roles = Role.all
  end

  def create
    @group = Group.find(params[:involvement][:group_id])
    @title = "Join a #{@group.name}"
    @involvement = @group.involvements.new(params[:involvement].
                    merge(:edited_by => current_user.nickname))

    if current_user.id == params[:involvement][:user_id].to_i && @involvement.save
      success = true
    else
      success = false
    end
    
    respond_to do |format|
      format.html do
        if success 
          flash[:success] = "You have joined to group '#{@group.name}'" 
          unless @involvement.role_name_full.empty?
            flash[:success] += "as @involvement.role_name_full"
          end
          redirect_to group_path(@group)
        else
          @roles = Role.all
          render :new, :group_id => params[:group_id]
        end
      end
      format.js do
        @involvements = @group.involvements.includes(:role, :user)
      end
    end
  end
  
  def destroy
    @involvement = Involvement.find(params[:id])
    @group = @involvement.group
    
    if current_user.id == @involvement.user_id && @involvement.destroy
      success = true
    else
      success = false
    end
    
    respond_to do |format|
      format.html do
        if success     
          flash[:success] = "Involvement was removed"
        else 
          flash[:error] = "You're not allowed to remove this involvement"    
        end
        redirect_to group_path(@group)
      end
      format.js do
        @involvements = @group.involvements.includes(:role, :user)
      end
    end
  end

end
