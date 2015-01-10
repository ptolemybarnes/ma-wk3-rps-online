require 'sinatra/base'
require_relative 'rps.bkend'
require 'byebug'

class RockPaperScissor < Sinatra::Base
enable :sessions
rps   = RockPaperScissorGame.new

#######     Routes    ########

  get '/' do
    session[:score] = {you: 0, opponent: 0}
    @rounds = params[:rounds]

    erb :gamepage
  end

  post '/' do
    @rounds     = params[:rounds].to_i
    @compchoice = RockPaperScissorGame.random_choice
    @yourchoice = params[:choice].to_sym
    @outcome    = rps.choose(@yourchoice, @compchoice)
    
    unless @outcome == :tie
      @winner     = identify_winner(compchoice: @compchoice,
                                    yourchoice: @yourchoice,
                                    outcome:    @outcome)
      @rounds -= 1
      add_to_score @winner
    end

    erb :gameoutcomepage, :layout => :gamepage
  end

######## Helper Methods ########

  helpers do

    def identify_winner args
      args[:compchoice] == args[:outcome] ? :opponent : :you
    end
    
    def add_to_score winner
      session[:score][winner] += 1
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end