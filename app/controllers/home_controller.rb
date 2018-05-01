class HomeController < ApplicationController
  include HomeHelper
  def index
  end

  def verify
    @user = current_user
    session[:key] ||= generate_key
    @key = session[:key]
  end

  def confirm_verify
    summoner = params[:user][:summoner_name]
    @key = session[:key]

    unless @key == summoner_verification_code(summoner)
      redirect_to verify_path, notice: 'yikes'
      return
    end

    @user = current_user
    @user.summoner_name = summoner
    if @user.save
      redirect_to root_path, notice: 'it worked!'
    else
      redirect_to verify_path, notice: 'yikes'
    end
  end
end
