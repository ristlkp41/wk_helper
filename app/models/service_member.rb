class ServiceMember < ApplicationRecord

  has_many :passages

  validates :rank, presence: true
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :ahv_number, presence: true, uniqueness: true

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
