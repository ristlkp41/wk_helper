module Zuko
  class SecuredController < ApplicationController

    before_action :ensure_access_allowed

    private

    def ensure_access_allowed
      unless current_user.present? && current_user.is_zuko?
        flash[:alert] = I18n.t('helpers.permissions.forbidden')
        redirect_to root_path
      end
    end

  end
end
