require 'sinatra/base'
require 'pry'
require './gifbot'

class GifBotWeb < Sinatra::Base
  set :logging, true

  post "/add" do
    gifitize = GifBot.new
    gif = gifitize.add_gif params[:username], params[:url]
    gif.id.to_s
  end

  get "/get_gif" do
    gifitize = GifBot.new
    if params[:tag] 
      gif = gifitize.random_gif_by_tag params[:tag]
      gif.to_json
    else
      gif = gifitize.random_gif
      gif.to_json
    end
  end

  get "/gif_list" do
    gifitize = GifBot.new
     if params[:tag] 
      g = gifitize.list_by_tag params[:tag]
      g.to_json
    else
      g = gifitize.all_gifs
      g.to_json
    end
  end

  post "/tag_gif" do
    gifitize = GifBot.new
    t = gifitize.tag_gif params[:id], params[:tag_name]
    t.to_json
  end


  # post "/add" do
  #   listicize = ToDoList.new
  #   item = listicize.create_entry params[:list], params[:description], params[:due_date]
  #   item.id.to_s
  # end

  get "/list/:name" do
    list = List.find_by_list_name! params[:name]
    list.items.to_json
  end
end

# $0 is $PROGRAM_NAME
if $0 == __FILE__
  ToDoWeb.start!
end