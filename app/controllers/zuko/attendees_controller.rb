module Zuko
  class AttendeesController < ApplicationController

    def index
      @service_members = ServiceMember.attending.order('lastname ASC, firstname ASC')
    end

  end
end
