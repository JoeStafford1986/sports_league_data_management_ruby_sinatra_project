require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/team.rb' )



#show all teams
get '/teams' do
  @teams = Team.all()
  erb ( :"teams/index" )
end

#show singular team

get '/teams/:id' do
  @team = Team.find(params[:id])
  erb(:"teams/show")
end

#go to edit form

get '/teams/:id/edit' do
  @team = Team.find(params[:id])
  erb(:"teams/edit")
end

#run update on edited team

post '/teams/:id/edit' do
  team = Team.new(params)
  team.update()
  redirect '/'
end
