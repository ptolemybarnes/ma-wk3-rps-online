require 'sinatra/base'
require_relative 'rps.bkend'
require 'byebug'

class RockPaperScissor < Sinatra::Base

rps = RockPaperScissorGame.new

  get '/*' do
    @rounds = params[:splat].sample
    erb :gamepage
  end

  post '/' do
    @rounds     = (params[:rounds].to_i - 1).to_s
    @compchoice = RockPaperScissorGame.random_choice
    @outcome    = rps.choose(params[:choice].to_sym, @compchoice)
    erb :gameoutcomepage, :layout => :gamepage
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end