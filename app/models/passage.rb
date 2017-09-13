class Passage < ApplicationRecord

  WAY_IN = 'in'.freeze
  WAY_OUT = 'out'.freeze
  WAYS = [WAY_IN, WAY_OUT].freeze

  belongs_to :service_member

  validates :passed_at, presence: true
  validates :way, presence: true, inclusion: WAYS

  after_initialize :assign_defaults

  def in?
    way == WAY_IN
  end

  def out?
    way == WAY_OUT
  end

  private

  def assign_defaults
    self.passed_at ||= Time.now

    if self.way.nil?
      if service_member.present? && service_member.last_passage.present?
        self.way ||= (service_member.last_passage.in? ? WAY_OUT : WAY_IN)
      end
      self.way ||= WAY_IN
    end
  end

end
