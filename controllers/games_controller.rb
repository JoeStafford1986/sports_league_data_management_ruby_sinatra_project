require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/game.rb' )

#show all games
get '/games' do
  @games = Game.all()
  erb ( :"games/index" )
end

#show singular game

get '/games/:id' do
  @game = Game.find(params[:id])
  erb(:"games/show")
end

#go to edit form

get '/games/:id/edit' do
  @game = Game.find(params[:id])
  erb(:"games/edit")
end
