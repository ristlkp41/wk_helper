require 'roo'

module Import
  class ServiceMemberListParser

    attr_reader :file

    def initialize(file)
      @file = file
    end

    def parse
      xlsx = Roo::Spreadsheet.open(file, extension: :xlsx)

      sheet = xlsx.sheet(xlsx.sheets.first)
      (1..sheet.last_row).reduce({}) do |list, number|
        # Skip header row
        next list if number == 1

        attrs = extract_attributes(sheet.row(number))

        # Use existing service member if present
        record = ServiceMember.find_or_initialize_by(ahv_number: attrs[:ahv_number])
        record.assign_attributes(attrs)

        list.merge(number => record)
      end
    end

    private

    def extract_attributes(row)
      {
        rank: row[0],
        lastname: row[1]&.split(',', 2)&.first,
        firstname: row[1]&.split(',', 2)&.last,
        ahv_number: row[80],
        imported_at: Time.now
      }
    end

  end
end
