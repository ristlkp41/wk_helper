class Admin::ServiceMembersController < ApplicationController

  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    @service_members = ServiceMember.all.order('lastname ASC, firstname ASC')
  end

  def show
  end

  def new
    @service_member = ServiceMember.new
  end

  def create
    @service_member = ServiceMember.new(service_member_params)
    if @service_member.save
      flash[:notice] = I18n.t('helpers.flashes.create.notice', model: ServiceMember.model_name.human)
      redirect_to admin_service_member_path(@service_member)
    else
      flash[:alert] = I18n.t('helpers.flashes.create.alert', model: ServiceMember.model_name.human)
      render :new
    end
  end

  def edit
  end

  def update
    if @service_member.editable? && @service_member.update_attributes(service_member_params)
      flash[:notice] = I18n.t('helpers.flashes.update.notice', model: ServiceMember.model_name.human)
      redirect_to admin_service_member_path(@service_member)
    else
      flash[:alert] = I18n.t('helpers.flashes.update.alert', model: ServiceMember.model_name.human)
      render :edit
    end
  end

  def destroy
    if @service_member.deletable?
      @service_member.destroy

      flash[:notice] = I18n.t('helpers.flashes.destroy.notice', model: ServiceMember.model_name.human)
      redirect_to admin_service_members_path
    else
      flash[:alert] = I18n.t('helpers.flashes.destroy.alert', model: ServiceMember.model_name.human)
      redirect_to admin_service_member_path(@service_member)
    end
  end

  private

  def set_resource
     @service_member = ServiceMember.find(params[:id])
  end

  def service_member_params
    params.require(:service_member).permit(:rank, :lastname, :firstname, :ahv_number)
  end

end
