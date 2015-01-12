require 'byebug'
require 'sinatra/base'
require 'sinatra/partial'

require_relative 'rps.bkend'
require_relative 'rps-rounds.bkend'
require_relative 'rps-multiplayer.bkend'

class RockPaperScissor < Sinatra::Base
  set :public_dir, Proc.new{File.join(root, '..', "public")}
  set :public_folder, 'public'
  enable :sessions

  configure do
    register Sinatra::Partial
    set :partial_template_engine, :erb
  end

#######     Routes    ########

  get '/' do
    redirect to '/newgame' unless valid_parameters? params
    @rps_game   = ObjectSpace._id2ref(session[:game_id])
    
    

    name              = params[:name]
    @rounds           = params[:rounds]
    session[:names]   = [name]

    # Adds given number of computer players to game.
    params[:player_count].to_i.times do |num|
      session[:names].push ("Opponent" + (num+1).to_s)
    end
  
    
    session[:names].each {|name| @rps_game.add_player name}

    # unless @rps_game.player_count == (params[:player_count].to_i + params[:human_player_count].to_i)
    #   redirect to('/waiting')
    # end

    @rps_game.start_game @rounds.to_i
    
    
    
    partial( :top ) + partial( :gamepage ) + partial( :bottom )
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
      partial( :top ) + partial( :gameoutcomepage ) + partial( :bottom )
    else
      partial( :top ) + partial( :gameoutcomepage ) + partial( :gamepage ) + partial( :bottom )
    end
  end


  get '/newgame' do
    session[:game_id] = RpsMultiplayer.new.object_id
    partial( :top ) + partial( :newgame ) + partial( :bottom )
  end

#######     HELPERS    ########

  helpers do

    def valid_parameters? params
      return false unless ['name', 'rounds', 'player_count'].all? {|needed_val| params.key? needed_val }
      return false unless (params['rounds'].to_i) > 0 and (params['player_count'].to_i > 0)
      true
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end