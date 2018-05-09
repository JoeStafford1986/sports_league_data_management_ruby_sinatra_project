require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/data_manager.rb' )
require_relative( '../models/game.rb' )
require_relative( '../models/team.rb' )

get '/stats' do
  sorted_teams = DataManager.sort_by_wins()
  @sorted_teams_wins_then_goals = DataManager.sort_teams()
  erb( :"data_managers/index")
end
