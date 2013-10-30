class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee
  has_many :players
  has_many :matches
  validates_presence_of :user, :referee
end
