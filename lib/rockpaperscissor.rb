require 'byebug'
require 'sinatra/base'

require_relative 'rps.bkend'
require_relative 'rps-rounds.bkend'

class RockPaperScissor < Sinatra::Base
enable :sessions
rps   = RockPaperScissorGame.new

#######     Routes    ########

  get '/' do
    @rounds         = params[:rounds] || 1
    @rps_game = RockPaperScissorRounds.new(:you, :opponent)
    @rps_game.playgame @rounds.to_i
    session[:game_id] = @rps_game.object_id

    erb :gamepage
  end

  post '/' do
    @compchoice = RockPaperScissorGame.random_choice
    @yourchoice = params[:choice].to_sym
    @rps_game    = ObjectSpace._id2ref(session[:game_id])

    @outcome    = @rps_game.play_round(you: @yourchoice, opponent: @compchoice)

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