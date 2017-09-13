require 'rails_helper'

RSpec.describe Passage, type: :model do

  context 'defaults' do
    it 'assigns current time for passed_at' do
      expect(Passage.new.passed_at).to be_within(5.seconds).of(Time.now)
    end

    it 'assigns "in" as the way if no service member present' do
      expect(Passage.new.way).to eql(Passage::WAY_IN)
    end

    context 'with service member present' do
      before(:each) do
        @service_member = Fabricate(:service_member)
      end

      it 'assigns "in" if no last passage is present' do
        passage = Passage.new(service_member: @service_member)
        expect(passage.way).to eql(Passage::WAY_IN)
      end

      it 'assigns "out" if way of last passage is "in"' do
        Fabricate(:passage, service_member: @service_member, way: Passage::WAY_IN)

        passage = Passage.new(service_member: @service_member)
        expect(passage.way).to eql(Passage::WAY_OUT)
      end

      it 'assigns "in" if way of last passage is "out"' do
        Fabricate(:passage, service_member: @service_member, way: Passage::WAY_OUT)

        passage = Passage.new(service_member: @service_member)
        expect(passage.way).to eql(Passage::WAY_IN)
      end
    end
  end

  context 'validations' do
    it 'requires presence of relevant attributes' do
      passage = Passage.new
      expect(passage).to_not be_valid
      expect(passage.errors).to include(:service_member)
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
      passage = Passage.new(service_member: Fabricate.build(:service_member))
      expect(passage).to be_valid
    end
  end

end
