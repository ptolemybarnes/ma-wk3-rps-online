require 'sinatra/base'
require_relative 'rps.bkend'
require 'byebug'

class RockPaperScissor < Sinatra::Base
use Rack::Session::Cookie, :key => 'rack.session',
:path => '/',
:secret => 'secret'

rps   = RockPaperScissorGame.new

  get '/' do
    session[:computer] = 0
    session[:you] = 0
    @rounds = params[:rounds]

    erb :gamepage
  end

  post '/' do
    @rounds     = (params[:rounds].to_i - 1).to_s
    @compchoice = RockPaperScissorGame.random_choice
    @yourchoice = params[:choice].to_sym
    @outcome    = rps.choose(@yourchoice, @compchoice)
    
    unless @outcome == :tie
      @winner     = identify_winner(compchoice: @compchoice,
                                    yourchoice: @yourchoice,
                                    outcome:    @outcome)
      add_to_score @winner
    end

    erb :gameoutcomepage, :layout => :gamepage
  end

  helpers do

    def identify_winner args = {}
      args[:compchoice] == args[:outcome] ? :computer : :you
    end
    
    def add_to_score winner
      session[winner] += 1
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end