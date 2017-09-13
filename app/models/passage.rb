class Passage < ApplicationRecord

  WAY_IN = 'in'.freeze
  WAY_OUT = 'out'.freeze
  WAYS = [WAY_IN, WAY_OUT].freeze

  belongs_to :service_member

  validates :passed_at, presence: true
  validates :way, presence: true, inclusion: WAYS

end
