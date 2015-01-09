require 'sinatra/base'

class RockPaperScissor < Sinatra::Base
  
  get '/' do
    'Hello RockPaperScissor!'
    "<form action='/' method='post'>
      <input type='submit' name='choice' value='rock'>
      <input type='submit' name='choice' value='paper'>
      <input type='submit' name='choice' value='scissor'>
    </form>"
  end

  post '/' do
    "The computer chose scissors.
    #{params[:choice].capitalize} wins!"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end