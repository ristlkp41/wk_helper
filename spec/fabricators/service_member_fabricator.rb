Fabricator(:service_member) do
  rank { Faker::Name.title }
  lastname { Faker::Name.last_name }
  firstname { Faker::Name.first_name }
  ahv_number { "AHV Number ##{Fabricate.sequence(:ahv_number)}" }
end
