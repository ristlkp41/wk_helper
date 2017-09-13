Fabricator(:passage) do
  service_member
  passed_at { Time.now }
  way { Passage::WAYS.sample }
end
