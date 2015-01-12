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

engine = RpsMultiplayer.new
engine_id = engine.object_id

#######     Routes    ########

  get '/newgame' do
    partial( :top ) + partial( :newgame ) + partial( :bottom )
  end

  post '/gamesetup' do
    @rps_game   = ObjectSpace._id2ref(engine_id)
    redirect to '/newgame' unless valid_parameters? params

    @rps_game.add_player params[:name]

    redirect to '/waiting' if     @rps_game.game_in_progress

    # Adds given number of computer players to game.
    params[:computer_player_count].to_i.times do |num|
      @rps_game.add_player ("Opponent" + (num+1).to_s)
    end


    @rps_game.player_cap       = params[:computer_player_count].to_i + params[:human_player_count].to_i
    @rps_game.round_num        = params[:rounds].to_i
    @rps_game.game_in_progress = true

    redirect to '/waiting'
  end

  get '/waiting' do
    puts "REDIRECTED"
    @rps_game   = ObjectSpace._id2ref(engine_id)
    redirect to('/') if @rps_game.game_ready?
    erb :waitingpage
  end

# 

  get '/' do
    # unless @rps_game.player_count == (params[:player_count].to_i + params[:human_player_count].to_i)
    #   redirect to('/waiting')
    # end

    @rps_game   = ObjectSpace._id2ref(session[:game_id])
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



#######     HELPERS    ########

  helpers do

    def valid_parameters? params
      return false unless ['name', 'rounds', 'computer_player_count', 'human_player_count'].all? {|needed_val| params.key? needed_val }
      return false unless (params['rounds'].to_i) > 0 and (params['computer_player_count'].to_i > 0) and (params['human_player_count'].to_i > 0)
      true
    end

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end