class User < ActiveRecord::Base
  has_many :stats
  validates_uniqueness_of :name

  def last_game
    stats.order(created_at: :desc).first
  end

  def self.make_user
    print "Player, what is your name? >"
    User.where(name: gets.chomp).first_or_create!
  end
end