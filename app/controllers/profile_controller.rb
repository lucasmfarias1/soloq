class ProfileController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = current_user
    @user.image = params[:user][:image]
    if @user.save
      redirect_to profile_path(current_user), notice: 'Imagem alterada com sucesso!'
    else
      redirect_to profile_path(current_user), notice: 'Arquivo invalido.'
    end
  end
end
