class ProfileController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end

  def edit

  end

  def update
    # @user.summoner_name = params[:user][:summoner_name]
    #
    # redirect_to profile_path(current_user), notice: 'worked'
  end
end
