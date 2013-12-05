class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee
  has_many :players
  has_many :matches
  validates_presence_of :user, :referee, :name, :contest_type, :description, :deadline, :start
  validates_uniqueness_of :name
  
  validates_datetime :start, on_or_after: lambda{Date.current}
  validate :start_before_deadline
  validates_datetime :deadline, on_or_after: lambda{Date.current}
  
  def start_before_deadline
    errors.add(:start_before_deadline, "Start cannot be before deadline.") if self.deadline and self.start and self.deadline - self.start > 0
  end
end
