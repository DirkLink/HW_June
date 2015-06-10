require 'minitest/autorun'
require 'rack/test'

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
end


