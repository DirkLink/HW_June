require 'sinatra/base'
require 'json'
require 'pry'


class MyServer < Sinatra::Base
  enable :logging

  set :bind, "0.0.0.0"

  get '/say_stuff' do
    phrase = params[:param]
    svoice = params[:voice]
    # binding.pry
    system("say -v '#{svoice}' '#{phrase}'")
  end
end

MyServer.run!