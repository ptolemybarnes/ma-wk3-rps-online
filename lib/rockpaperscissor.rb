require 'sinatra/base'
require_relative 'rps.bkend'
require 'byebug'

class RockPaperScissor < Sinatra::Base
enable :sessions

rps   = RockPaperScissorGame.new
SCORE = {you: 0, computer: 0}

  get '/*' do
    @rounds = params[:splat].sample
    session[:score] = {you: 0, computer: 0}
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
      session[:score][winner] += 1
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end