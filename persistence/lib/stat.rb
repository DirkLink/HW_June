class Stat < ActiveRecord::Base
  belongs_to :player_x , class_name: "User"
  belongs_to :player_o , class_name: "User"

  validates_presence_of :player_o_id, :player_x_id 

  def self.wins user
    win_count = 0
    win_count += Stat.where(player_x_id: user.id).where(player_x_won: true).count
    win_count += Stat.where(player_o_id: user.id).where(player_o_won: true).count
    return win_count
  end

  def self.losses user
    loss_count = 0
    loss_count += Stat.where(player_x_id: user.id).where(player_x_won: false).where(draw: false).count
    loss_count += Stat.where(player_o_id: user.id).where(player_o_won: false).where(draw: false).count
    return loss_count
  end
end  