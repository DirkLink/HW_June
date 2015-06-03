class Tables < ActiveRecord::Migration
  def change
    create_table "users" do |t|
      t.string "name"
    end
    create_table "stats" do |t|
      t.integer "player_x_id"
      t.integer "player_o_id"
      t.boolean "player_x_won"
      t.boolean "player_o_won"
      t.datetime "created_at"
    end
  end
end
