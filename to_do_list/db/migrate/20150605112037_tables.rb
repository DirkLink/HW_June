class Tables < ActiveRecord::Migration
  def change
    create_table "users" do |t|
      t.string "name"
    end

    create_table "tasks" do |t|
      t.integer "user_id"
      t.string "task"
      t.datetime "due_date"
      t.boolean "completed"
      t.datetime "created_at"
    end
  end
end
