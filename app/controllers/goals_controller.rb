class GoalsController < ApplicationController
  def create
    @goal = Goal.new(goal_params)
    fail

    unless @goal.save
      flash[:errors] = @goal.errors.full_messages
    end
    redirect_to user_url(@goal.user)
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])

    unless @goal.update(goal_params)
      flash[:errors] = @goal.errors.full_messages
    end
    redirect_to user_url(@goal.user)
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def destroy
    goal = Goal.find(params[:id])
    user_id = goal.user_id
    goal.destroy!
    redirect_to user_url(user_id)
  end

  private
  def goal_params
    params[:goal][:user_id] = current_user.id
    params[:goal][:completed] = false
    params.require(:goal).permit(:content, :private, :completed, :user_id)
  end
end
