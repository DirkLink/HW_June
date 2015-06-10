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
    # binding.pry
    assert_equal 200, last_response.status
    
    assert_equal "true", last_response.body
  end

end


