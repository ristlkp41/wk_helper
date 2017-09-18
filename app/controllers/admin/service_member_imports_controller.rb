module Admin
  class ServiceMemberImportsController < SecuredController

    def new
    end

    def create
      file = service_member_import_params[:file]
      unless file.present? && File.exist?(file.path) && file.path.end_with?('.xlsx')
        flash[:alert] = I18n.t('admin.service_member_imports.create.invalid_file')
        render :new
        return
      end

      service_member_list = Import::ServiceMemberList.new(file.path)
      if service_member_list.save
        flash[:notice] = I18n.t('admin.service_member_imports.create.notice')
        redirect_to admin_service_members_path
      else
        flash[:alert] = I18n.t('admin.service_member_imports.create.alert', rows: service_member_list.errors.keys.join(', '))
        render :new
      end
    end

    private

    def service_member_import_params
      params.require(:service_member_import).permit(:file)
    end

  end
end
