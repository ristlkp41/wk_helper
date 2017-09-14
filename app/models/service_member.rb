class ServiceMember < ApplicationRecord

  has_many :passages

  validates :rank, presence: true
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :ahv_number, presence: true, uniqueness: true

  scope :attending, -> { joins(:passages).where('passages.passed_at = (SELECT MAX(passed_at) FROM passages WHERE service_member_id = service_members.id)').where('passages.way = ?', Passage::WAY_IN) }

  def last_passage
    passages.order(passed_at: :desc).limit(1).first
  end

  def editable?
    imported_at.nil?
  end

  def deletable?
    passages.empty?
  end

end
