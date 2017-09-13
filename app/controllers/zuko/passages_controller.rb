class Zuko::PassagesController < ApplicationController

  def new
  end

  def create
    @service_member = ServiceMember.find_by(ahv_number: passage_params[:ahv_number])

    if @service_member.present?
      flash[:notice] = I18n.t('zuko.passages.create.notice')
      @passage = Passage.create!(service_member: @service_member)
    else
      flash[:alert] = I18n.t('zuko.passages.create.alert')
    end

    render :new
  end

  private

  def passage_params
    params.require(:passage).permit(:ahv_number)
  end

end
