require 'rails_helper'

describe Admin::ServiceMembersController, type: :controller do

  describe '#update' do
    it 'does not change uneditable service members' do
      service_member = Fabricate(:service_member)
      allow_any_instance_of(ServiceMember).to receive(:editable?).and_return(false)

      expect {
        put :update, params: { id: service_member.id, service_member: { rank: 'RSPEC' } }
      }.not_to change { service_member.rank }
    end
  end

  describe '#destroy' do
    it 'does not delete undeletable service members' do
      service_member = Fabricate(:service_member)
      allow_any_instance_of(ServiceMember).to receive(:deletable?).and_return(false)

      expect {
        delete :destroy, params: { id: service_member.id }
      }.not_to change { ServiceMember.count }
    end
  end

end
