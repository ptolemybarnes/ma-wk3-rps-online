require 'byebug'
require 'sinatra/base'

require_relative 'rps.bkend'
require_relative 'rps-rounds.bkend'
require_relative 'rps-multiplayer.bkend'

class RockPaperScissor < Sinatra::Base
enable :sessions

#######     Routes    ########

  get '/' do

    unless ['name', 'rounds', 'player_count'].all? {|needed_val| params.key? needed_val }
      redirect to '/newgame'
    end

    name              = params[:name]
    @rounds           = params[:rounds]
    session[:names]   = [name]


    params[:player_count].to_i.times do |num|
      session[:names].push ("Opponent" + (num+1).to_s)
    end
  
    @rps_game         = RpsMultiplayer.new
    session[:names].each {|name| @rps_game.add_player name}

    @rps_game.start_game @rounds.to_i
    
    session[:game_id] = @rps_game.object_id
    
    erb :gamepage
  end

  post '/' do
    @rps_game   = ObjectSpace._id2ref(session[:game_id])
    @rps_game.clear_moves

    @yourname   = params[:name]
    @yourchoice = params[:choice].to_sym

    @rps_game.moves << [@yourname, @yourchoice]
    (@rps_game.game.names - [@yourname]).each do |opponent|
      @rps_game.moves << [opponent, RockPaperScissorGame.random_choice]
    end
    
    @outcome    = @rps_game.play_round

    if @rps_game.game.winner?
      erb :gameoutcomepage
    else
      erb :gameoutcomepage, :layout => :gamepage
    end
  end

  get '/newgame' do
    erb :newgame
  end

  get '/standby' do

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end