class Column < ActiveRecord::Migration
  def change
    add_column :stats, :draw, :boolean
  end
end
