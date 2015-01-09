require 'sinatra/base'
require 'rps.bkend'
require 'byebug'

class RockPaperScissor < Sinatra::Base

rps = RockPaperScissorGame.new

  get '/' do
    "<form action='/' method='post'>
      <input type='submit' name='choice' value='rock'>
      <input type='submit' name='choice' value='paper'>
      <input type='submit' name='choice' value='scissors'>
    </form>"
  end

  post '/' do
    compchoice = RockPaperScissorGame.random_choice
    outcome = rps.choose(params[:choice].to_sym, compchoice)
    if outcome == :tie
      "The computer chose #{compchoice.to_s}. Game was a tie."
    else
      "The computer chose #{compchoice.to_s}. #{outcome.to_s.capitalize} wins!"
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end