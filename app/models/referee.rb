class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :contests
  has_many :matches, as: :manager
  
  validates_presence_of :name, :rules_url, :players_per_game, :file_location
  validates_uniqueness_of :name
  validates :players_per_game, numericality: { greater_than: 0, less_than: 11, only_integer: true }
  validates :rules_url, format: /\A(http[s]*:\/\/)([\w-]+\.)+[\w-]{2,3}(\/[\w-]*)*(\/[\w-]+\.[\w-]+)*(\?[\w-]+=[\w-]+)?(&[\w-]+=[\w-]+)*\z/
  
  validate :file_exists
  include Uploadable
  
  def file_exists
    errors.add(:file_location, "File does not exist.") if !self.file_location.nil? and !File.exist?(self.file_location)
  end
  
  def referee
    self
  end
end
