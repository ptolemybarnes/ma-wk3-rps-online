require 'byebug'
require 'sinatra/base'

require_relative 'rps.bkend'
require_relative 'rps-rounds.bkend'
require_relative 'rps-multiplayer.bkend'

class RockPaperScissor < Sinatra::Base
enable :sessions

#######     Routes    ########

  get '/' do
    name              = params[:name] || :you

    session[:names]   = [name, :opponent]
    @rounds           = params[:rounds] || 1
    
    @rps_game         = RpsMultiplayer.new

    session[:names].each {|name| @rps_game.add_player name}

    @rps_game.start_game @rounds.to_i
    
      session[:game_id] = @rps_game.object_id
    
    erb :gamepage
  end

  post '/' do
    @rps_game   = ObjectSpace._id2ref(session[:game_id])
    @rps_game.clear_moves
    
    @compchoice = RockPaperScissorGame.random_choice
    puts params
    @yourname   = params[:name].empty? ? :you : params[:name]
    @yourchoice = params[:choice].to_sym

    @rps_game.moves << [@yourname, @yourchoice]
    @rps_game.moves << [:opponent, @compchoice]

    unless @rps_game.ready?
      redirect to('/standby')
    end

    @outcome    = @rps_game.play_round

    erb :gameoutcomepage, :layout => :gamepage
  end

  get '/standby' do


  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end