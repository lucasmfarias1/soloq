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

    summoner_id = get_summoner_id(summoner)
    unless @key == get_summoner_verification_code(summoner_id)
      redirect_to verify_path, notice: 'Verification failed.'
      return
    end

    @user.summoner_name = summoner
    @user.summoner_id = summoner_id
    if @user.save
      update_rank(@user)
      redirect_to root_path, notice: 'Changes saved!'
    else
      redirect_to verify_path, notice: 'Failed to save.'
    end
  end

  private

  def update_rank(user)
    tier_rank = get_user_tier_rank(user)
    user.tier = tier_rank[0]
    user.rank = tier_rank[1]
    user.save
  end

end
