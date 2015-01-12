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

GAME_ENGINES = []

#######     Routes    ########

  get '/newgame' do
    if games_joinable? 
      joingame = partial( :joingame )
    else
      joingame = ""
    end

    partial( :top ) + partial( :newgame ) + joingame + partial( :bottom )
  end

  post '/gamesetup' do
    redirect to '/newgame' unless valid_parameters? params
    @rps_game           = RpsMultiplayer.new
    GAME_ENGINES << @rps_game
    session[:engine_id] = @rps_game.object_id
    
    # Adds given number of computer players to game.
    params[:computer_player_count].to_i.times do |num|
      @rps_game.add_player ("Opponent" + (num+1).to_s)
    end

    @rps_game.player_cap       = params[:computer_player_count].to_i + params[:human_player_count].to_i
    @rps_game.round_num        = params[:rounds].to_i

    redirect to "/waiting?#{params[:name]}"
  end

  get '/waiting' do
    @rps_game   = ObjectSpace._id2ref(session[:engine_id])
    @rps_game.add_player params[:name]

    if @rps_game.game_ready?
      @rps_game.game_in_progress = true
      redirect to('/')
    end

    erb :waitingpage
  end

  get '/' do
    redirect to('/newgame') unless session[:engine_id]

    @rps_game   = ObjectSpace._id2ref(session[:engine_id])
    @rps_game.start_game
    partial( :top ) + partial( :gamepage ) + partial( :bottom )
  end


  post '/' do

    @rps_game   = ObjectSpace._id2ref(session[:engine_id])

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

  get '/clearallgames' do
    GAME_ENGINES.clear
  end



#######     HELPERS    ########

  helpers do

    def valid_parameters? params
      return false unless ['name', 'rounds', 'computer_player_count', 'human_player_count'].all? {|needed_val| params.key? needed_val }
      return false unless (params['rounds'].to_i) > 0 and ((params['computer_player_count'].to_i + params['human_player_count'].to_i) > 0)
      true
    end

    def games_joinable?
      GAME_ENGINES.reject {|game| game.game_in_progress }.count > 0
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end