class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest
  has_many :player_matches
  has_many :matches, through: :player_matches
  validates_presence_of :name, :description, :user_id, :contest_id
  validate :unique_in_contest
  validate :file_exists
  include Uploadable
  
  def file_exists
    errors.add(:file_location, "File does not exist.") if !self.file_location.nil? and !File.exist?(self.file_location)
  end
  
  def unique_in_contest
    contest = Contest.find_by_id(self.contest_id)
    if contest.nil?
      errors.add(:contest, "Invalid contest")
      return
    end
    record=contest.players.where("name = ?", self.name)
    errors.add(:player,"Can't be same name") if !record.empty? and record[0].id != self.id
  end
  
end
