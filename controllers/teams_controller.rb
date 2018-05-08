require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/team.rb' )



#show all teams
get '/teams' do
  @teams = Team.all()
  @sorted_teams = Team.sort_by_wins()
  erb ( :"teams/index" )
end

#go to form to add team
get '/teams/new' do
  erb(:"teams/new")
end

#add new team
post '/teams' do
  @team = Team.new(params)
  @team.save()
  redirect '/'
end

#show singular team
get '/teams/:id' do
  @team = Team.find(params[:id])
  @games = @team.games()
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

#delete team
post '/teams/:id/delete' do
  team = Team.find(params[:id])
  team.delete()
  redirect '/'
end
