require 'sinatra/base'

class RockPaperScissor < Sinatra::Base
  get '/' do
    'Hello RockPaperScissor!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
