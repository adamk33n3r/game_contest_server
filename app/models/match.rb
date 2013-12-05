class Match < ActiveRecord::Base
  belongs_to :manager, polymorphic: true
  has_many :player_matches
  has_many :players, through: :player_matches
  validates_presence_of :manager, :status
  validate :earliest
  validate :completion_date
  validate :player_count
  
  def player_count
    errors.add(:match, "Not correct number of players.") unless !self.manager.nil? and self.players.count == self.manager.referee.players_per_game
  end
  
  def earliest
    errors.add(:match, "Not valid earliest_start.") if self.earliest_start.nil? and (self.status == "Unknown Status" or self.status == "Waiting")
  end
  
  def completion_date
    errors.add(:match, "Not valid completion date.") if self.completion - Date.today > 0 and self.status != "Unknown Status"
  end
end
