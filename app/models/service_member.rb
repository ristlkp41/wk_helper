class ServiceMember < ApplicationRecord

  validates :rank, presence: true
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :ahv_number, presence: true, uniqueness: true

end
