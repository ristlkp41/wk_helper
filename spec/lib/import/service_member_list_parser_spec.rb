require 'rails_helper'

describe Import::ServiceMemberListParser do

  describe '#parse' do
    it 'returns a hash with row number as key and a service member object as value' do
      list = Import::ServiceMemberListParser.new(Rails.root.join('spec', 'fixtures', 'service_member_list-valid.xlsx')).parse

      expect(list[2].rank).to eql('Soldat')
      expect(list[2].lastname).to eql('Läppli')
      expect(list[2].firstname).to eql('Theophil')
      expect(list[2].ahv_number).to eql('756.0000.0000.00')
    end

    it 'loads the object with the same ahv number if available and assigns the attributes' do
      Fabricate(:service_member, ahv_number: '756.0000.0000.00', rank: 'Hauptmann')
      
      list = Import::ServiceMemberListParser.new(Rails.root.join('spec', 'fixtures', 'service_member_list-valid.xlsx')).parse    
      expect(list[2]).to_not be_new_record
      expect(list[2]).to be_changed
      expect(list[2].rank).to eql('Soldat')
    end

    it 'initializes new object with attributes otherwise' do
      list = Import::ServiceMemberListParser.new(Rails.root.join('spec', 'fixtures', 'service_member_list-valid.xlsx')).parse    
      expect(list[2]).to be_new_record
    end
  end

end
