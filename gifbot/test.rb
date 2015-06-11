require 'minitest/autorun'
require 'rack/test'
require "minitest/reporters"
Minitest::Reporters.use!
require './db/setup'
require './lib/all'

require './server'

require 'pry'

class GifBotTest < Minitest::Test
  include Rack::Test::Methods

  def app 
    GifBotWeb
  end

  def setup
    Gif.delete_all
    User.delete_all
    Tag.delete_all
    GifTag.delete_all
  end

  def test_users_can_add_gifs
    u = User.create! name: "cat" 

    post "/add",
      username: u.name,
      url: "http://imgur.com/IDFyJ4x.gifv"
      assert_equal 200, last_response.status

    gif = Gif.find_by_creator_id u.id

    assert gif
    assert_equal gif.id.to_s, last_response.body
  end

  def test_random_gifs
    u = User.create! name: "shark" 
    p = User.create! name: "pancake"
    b = User.create! name: "baby"
    r = User.create! name: "robot"
    u.gifs.create! url: "http://i.imgur.com/mKrmlcP.gifv", seen_count: 0
    p.gifs.create! url: "http://i.imgur.com/62Y5dHy.gif", seen_count: 0
    b.gifs.create! url: "http://i.imgur.com/DcTnzPt.gif", seen_count: 0
    r.gifs.create! url: "http://i.imgur.com/TPxSd6T.gif", seen_count: 0
        
    get "/get_gif"
    assert_equal 200, last_response.status
    gif = JSON.parse last_response.body
    assert_equal 1, gif["seen_count"]
  end

  def test_list_all_gifs
    u = User.create! name: "shark" 
    p = User.create! name: "pancake"
    b = User.create! name: "baby"
    r = User.create! name: "robot"
    u.gifs.create! url: "http://moar.edgecats.net/cats/funny-gifs-force-moves-on-the-cat.gif", seen_count: 0
    p.gifs.create! url: "http://i.imgur.com/SoE0tYl.gifv", seen_count: 0
    b.gifs.create! url: "http://i.imgur.com/0fW3P6x.gifv", seen_count: 0
    r.gifs.create! url: "http://i.imgur.com/c3Bmo0j.gifv", seen_count: 0
    
    get "/gif_list"

    assert_equal 200, last_response.status

    gifs = JSON.parse last_response.body
    assert_equal 4, gifs.count

    first_gif = gifs.first
    assert_equal "http://moar.edgecats.net/cats/funny-gifs-force-moves-on-the-cat.gif", first_gif["url"]
  end

  def test_annotate_gif_any_tag
    p = User.create! name: "pancake"
    g = p.gifs.create! url: "http://i.imgur.com/fi4buEv.gifv", seen_count: 0
    
    post "/tag_gif",
    id: g.id,
    tag_name: "belly flop dive"

    tagged = GifTag.find_by_gif_id g.id 

    tagname = Tag.find(tagged.id)

    t = JSON.parse last_response.body
    assert_equal t["id"].to_i, tagged.tag_id

    assert_equal 200, last_response.status
    assert_equal tagname.name, "belly flop dive"

  end

  # def test_limit_list_tag
  #   u = User.create! name: "croc" 
  #   u.gifs.create! url: "http://i.imgur.com/mCRLB6W.gifv", seen_count: 0
  #   u.gifs.create! url: "http://i.imgur.com/dBR0MKn.gifv", seen_count: 0
  #   u.gifs.create! url: "http://i.imgur.com/O8yqH82.gifv", seen_count: 0
  #   u.gifs.create! url: "http://i.imgur.com/uyHfOjV.gifv", seen_count: 0


end































