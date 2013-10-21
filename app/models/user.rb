class User < ActiveRecord::Base
  has_secure_password
  validates :username, :presence => true, :uniqueness => true, :length => {:maximum => 25}
  validates :email, :presence => true, :format =>  /\A[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}\z/i #/\A([^@\s]+)@taylor\.edu\z/i
  validates :password, :length => {:minimum => 6}
  def to_param
    username
    id
  end
end
