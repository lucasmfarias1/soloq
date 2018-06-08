class HomeController < ApplicationController
  include HomeHelper

  before_action :authenticate_user!, except: [:welcome]

  def welcome
    unless current_user
      redirect_to new_user_session_path
      return
    end

    @user = current_user
    if @user.profile
      redirect_to home_path
    elsif @user
      # generate_key
      @profile = Profile.create(verification_key: 'soloq09caef7a')
      @user.profile = @profile
    else
      redirect_to new_user_session_path
    end
  end

  def index
    @posts = Post.order(:created_at).page params[:page]
    @post = Post.new
  end

  def verify
    @user = current_user
    @profile = @user.profile
    @key = @profile.verification_key
  end

  def confirm_verify
    summoner = params[:profile][:name]
    @user = current_user
    @profile = @user.profile
    @key = @profile.verification_key

    summoner_id_name = get_summoner_id_name(summoner)
    unless @key == get_summoner_verification_code(summoner_id_name[0])
      redirect_to verify_path, notice: 'Verification failed.'
      return
    end

    @profile.lol_id = summoner_id_name[0]
    @profile.name = summoner_id_name[1]
    if @profile.save
      update_rank(@profile)
      redirect_to root_path, notice: 'Changes saved!'
    else
      redirect_to verify_path, notice: 'Failed to save.'
    end
  end

  def delete_verify
    @user = current_user
    @profile = @user.profile
    @profile.name = nil
    @profile.lol_id = nil
    @profile.rank = nil
    @profile.tier = nil
    if @profile.save
      redirect_to verify_path, notice: 'Summoner desvinculado com sucesso.'
    else
      redirect_to verify_path, notice: 'Alguma coisa deu errado.'
    end
  end

  private

  def update_rank(profile)
    tier_rank = get_user_tier_rank(profile)
    profile.tier = tier_rank[0]
    profile.rank = tier_rank[1]
    profile.save
  end

end
