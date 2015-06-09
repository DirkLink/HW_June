require 'sinatra/base'
require 'json'
require 'pry'


class MyServer < Sinatra::Base
  enable :logging

  set :bind, "0.0.0.0"

  get '/say_hello' do
    system "say 'Hello world'"
  end

  # -----

  get "/bad/echo" do
    puts "What word? "
    word = gets.chomp
    "Your word was: #{word}"
  end

  delete "/echo/:word" do
    params[:word]
  end
end

MyServer.run!