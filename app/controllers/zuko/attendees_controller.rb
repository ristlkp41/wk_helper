module Zuko
  class AttendeesController < SecuredController

    def index
      @service_members = ServiceMember.attending.order('lastname ASC, firstname ASC')
    end

  end
end
