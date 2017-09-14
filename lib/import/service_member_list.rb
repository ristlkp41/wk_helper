module Import
  class ServiceMemberList

    attr_reader :file, :service_member, :errors

    def initialize(file)
      raise ArgumentError unless File.exist?(file)
      @file = file

      @service_members = ServiceMemberListParser.new(file).parse
      @errors = {}
    end

    def valid?
      @errors = {}

      @service_members.each do |line, service_member|
        next if service_member.valid?

        error_keys = service_member.errors.map { |key| ServiceMember.human_attribute_name(key) }
        @errors[line] = error_keys.join(', ')
      end

      @errors.none?
    end

    def save
      return false unless valid?

      ActiveRecord::Base.transaction do
        # Save service member records
        @service_members.each do |_line, service_member|
          service_member.save!
        end
      end
      true
    end

  end
end
