require 'httparty'

class Speaker

  include HTTParty
  base_uri '10.1.10.139:4567'

  def initialize voice=nil
    @voice = voice
  end

  def speak param
    Speaker.get("/say_stuff", query: { param: param, voice: @voice })
  end


  def me
    Speaker.get("/user")
  end
end
