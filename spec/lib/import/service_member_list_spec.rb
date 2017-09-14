require 'rails_helper'

describe Import::ServiceMemberList do

  describe '#valid?' do

    it 'returns true if all service member records are valid' do
      list = Import::ServiceMemberList.new(Rails.root.join('spec', 'fixtures', 'service_member_list-valid.xlsx'))
      expect(list).to be_valid
    end

    it 'returns false and sets the errors if a service member record is invalid' do
      list = Import::ServiceMemberList.new(Rails.root.join('spec', 'fixtures', 'service_member_list-invalid.xlsx'))
      expect(list).to_not be_valid
      expect(list.errors).to eql({
        2 => 'Nachname, Vorname'
      })
    end

  end

  describe '#save' do

    it 'saves all service members if list is valid' do
      expect {
        Import::ServiceMemberList.new(Rails.root.join('spec', 'fixtures', 'service_member_list-valid.xlsx')).save
      }.to change { ServiceMember.count }.by(1)
    end

    it 'does not save service members if list is not valid' do
      expect {
        Import::ServiceMemberList.new(Rails.root.join('spec', 'fixtures', 'service_member_list-invalid.xlsx')).save
      }.not_to change { ServiceMember.count }
    end

  end

end
