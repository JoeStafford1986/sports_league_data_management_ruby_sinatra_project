require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/game.rb' )

#show all games
get '/games' do
  @games = Game.all()
  erb ( :"games/index" )
end
