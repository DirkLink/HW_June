class CreateGifs < ActiveRecord::Migration
  def change
    create_table "gifs" do |t|
      t.string "url"
      t.datetime "created_at"
    end
  end
end

class AddUsers < ActiveRecord::Migration
  def change
    add_column :gifs, :creator_id, :integer

    create_table "users" do |t|
      t.string "name"
    end
  end
end

class AddSeenCount < ActiveRecord::Migration
  def change
    add_column :gifs, :seen_count, :integer
  end
end

class AddTags < ActiveRecord::Migration
  def change
    create_table "tags" do |t|
      t.string "name"
    end

    create_table "gif_tags" do |t|
      t.integer "tag_id"
      t.integer "gif_id"
    end
  end
end
