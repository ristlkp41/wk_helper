Fabricator(:user) do
  username { "Username #{Fabricate.sequence(:username)}" }
  password { 'password' }
  password_confirmation { 'password' }
end
