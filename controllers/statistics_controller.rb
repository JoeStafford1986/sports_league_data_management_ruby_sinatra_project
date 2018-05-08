require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/game.rb' )
require_relative( '../models/team.rb' )

get '/stats' do
  @sorted_teams = Team.sort_by_wins()
  erb( :"statistics/index")
end
