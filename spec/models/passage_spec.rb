require 'rails_helper'

RSpec.describe Passage, type: :model do

  context 'validations' do
    it 'requires presence of relevant attributes' do
      passage = Passage.new
      expect(passage).to_not be_valid
      expect(passage.errors).to include(:service_member)
      expect(passage.errors).to include(:passed_at)
      expect(passage.errors).to include(:way)
    end

    it 'requires way to have a known value' do
      passage = Passage.new(way: 'rspec')
      expect(passage).to_not be_valid
      expect(passage.errors).to include(:way)

      passage.way = Passage::WAYS.sample
      passage.valid?
      expect(passage.errors).to_not include(:way)
    end

    it 'can be valid' do
      passage = Passage.new(service_member: Fabricate.build(:service_member), passed_at: Time.now, way: Passage::WAY_IN)
      expect(passage).to be_valid
    end
  end

end
