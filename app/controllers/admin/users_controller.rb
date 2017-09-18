class Admin::UsersController < ApplicationController

  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order('username ASC')
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = I18n.t('helpers.flashes.create.notice', model: User.model_name.human)
      redirect_to admin_user_path(@user)
    else
      flash[:alert] = I18n.t('helpers.flashes.create.alert', model: User.model_name.human)
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = I18n.t('helpers.flashes.update.notice', model: User.model_name.human)
      redirect_to admin_user_path(@user)
    else
      flash[:alert] = I18n.t('helpers.flashes.update.alert', model: User.model_name.human)
      render :edit
    end
  end

  def destroy
    @user.destroy

    flash[:notice] = I18n.t('helpers.flashes.destroy.notice', model: User.model_name.human)
    redirect_to admin_users_path
  end

  private

  def set_resource
     @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

end
