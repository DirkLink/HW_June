require 'httparty'

class Speaker

  include HTTParty
  base_uri '10.1.10.139:4567'

  # default_options[:headers] = {
  #   "Authorization" => "token #{Token}",
  #   "User-Agent"    => "Wandows Explrer"
  # }

  def initialize voice=nil

  end

  def speak param
    Speaker.get("/say_stuff", query: { param: param })
  end


  def me
    Speaker.get("/user")
  end
end

require "pry"
binding.pry