class HomeController < ApplicationController
  include HomeHelper
  def index
  end

  def verify
    @user = current_user

    unless @user.verification_key
      @user.verification_key = generate_key
      @user.save
    end
    @key = @user.verification_key
  end

  def confirm_verify
    summoner = params[:user][:summoner_name]
    @user = current_user
    @key = @user.verification_key

    unless @key == summoner_verification_code(summoner)
      redirect_to verify_path, notice: 'yikes'
      return
    end

    @user.summoner_name = summoner
    if @user.save
      redirect_to root_path, notice: 'it worked!'
    else
      redirect_to verify_path, notice: 'yikes'
    end
  end
end
