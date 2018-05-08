require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/team.rb' )



#show all teams
get '/teams' do
  @teams = Team.all()
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
  redirect '/teams'
end

#show singular team
get '/teams/:id' do
  @team = Team.find(params[:id])
  @teams = Team.all()
  @games = @team.games()
  # binding.pry
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
  redirect '/teams'
end

#delete team
post '/teams/:id/delete' do
  team = Team.find(params[:id])
  team.delete()
  redirect '/teams'
end
