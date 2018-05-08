class HomeController < ApplicationController
  include HomeHelper

  before_action :authenticate_user!, except: [:index]

  def index
    @users = User.all
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

    summoner_id_name = get_summoner_id_name(summoner)
    unless @key == get_summoner_verification_code(summoner_id_name[0])
      redirect_to verify_path, notice: 'Verification failed.'
      return
    end

    @user.summoner_id = summoner_id_name[0]
    @user.summoner_name = summoner_id_name[1]
    if @user.save
      update_rank(@user)
      redirect_to root_path, notice: 'Changes saved!'
    else
      redirect_to verify_path, notice: 'Failed to save.'
    end
  end

  def delete_verify
    @user = current_user
    @user.summoner_name = nil
    @user.summoner_id = nil
    @user.rank = nil
    @user.tier = nil
    if @user.save
      redirect_to verify_path, notice: 'Summoner desvinculado com sucesso.'
    else
      redirect_to verify_path, notice: 'Alguma coisa deu errado.'
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
