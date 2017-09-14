require 'rails_helper'

RSpec.describe ServiceMember, type: :model do

  context 'validations' do
    it 'requires presence of relevant attributes' do
      service_member = ServiceMember.new
      expect(service_member).to_not be_valid
      expect(service_member.errors).to include(:rank)
      expect(service_member.errors).to include(:lastname)
      expect(service_member.errors).to include(:firstname)
      expect(service_member.errors).to include(:ahv_number)
    end

    it 'requires unique ahv number' do
      first = Fabricate(:service_member, ahv_number: 'test')

      second = ServiceMember.new(ahv_number: 'test')
      expect(second).to_not be_valid
      expect(second.errors).to include(:ahv_number)

      second.ahv_number = 'test2'
      second.valid?
      expect(second.errors).to_not include(:ahv_number)
    end

    it 'can be valid' do
      service_member = ServiceMember.new(rank: 'Sdt', lastname: 'Muster', firstname: 'Hans', ahv_number: '000.0000.0000.00')
      expect(service_member).to be_valid
    end
  end

  context 'scopes' do
    describe '.attending' do

      it 'returns service members whose last passage was on the way in' do
        member_in = Fabricate(:service_member)
        Fabricate(:passage, service_member: member_in, way: Passage::WAY_IN, passed_at: 1.days.ago)
        Fabricate(:passage, service_member: member_in, way: Passage::WAY_OUT, passed_at: 2.days.ago)

        member_out = Fabricate(:service_member)
        Fabricate(:passage, service_member: member_out, way: Passage::WAY_OUT, passed_at: 1.day.ago)
        Fabricate(:passage, service_member: member_out, way: Passage::WAY_IN, passed_at: 2.day.ago)

        results = ServiceMember.attending
        expect(results).to include(member_in)
        expect(results).to_not include(member_out)
      end

    end
  end

  describe '#last_passage' do
    before(:each) do
      @service_member = Fabricate(:service_member)
    end

    it 'returns nil if no passage found' do
      expect(@service_member.last_passage).to eql(nil)
    end

    it 'returns the most current passage otherwise' do
      first = Fabricate(:passage, service_member: @service_member, passed_at: 2.days.ago)
      second = Fabricate(:passage, service_member: @service_member, passed_at: 1.days.ago)

      expect(@service_member.last_passage).to eql(second)
    end
  end

  describe '#editable?' do
    it 'returns false if service member has been imported' do
      service_member = Fabricate.build(:service_member, imported_at: Time.now)
      expect(service_member).to_not be_editable
    end

    it 'returns true if service member has been created manually' do
      service_member = Fabricate.build(:service_member, imported_at: nil)
      expect(service_member).to be_editable
    end
  end

  describe '#deletable?' do
    it 'returns false if passages have been recorded for this service member' do
      service_member = Fabricate(:service_member)
      Fabricate(:passage, service_member: service_member)

      expect(service_member).to_not be_deletable
    end

    it 'returns true otherwise' do
      service_member = Fabricate(:service_member)
      expect(service_member).to be_deletable
    end
  end

end
