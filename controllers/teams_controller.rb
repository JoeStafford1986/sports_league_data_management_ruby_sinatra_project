require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/team.rb' )

#return all teams
get '/teams' do
  @teams = Team.all()
  erb ( :"teams/index" )
end

get '/teams/:id' do
  @team = Team.find(params[:id])
  erb(:"teams/show")
end
