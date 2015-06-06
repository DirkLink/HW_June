class Column < ActiveRecord::Migration
  def change
    add_column :tasks, :list_name, :string 
  end
end
