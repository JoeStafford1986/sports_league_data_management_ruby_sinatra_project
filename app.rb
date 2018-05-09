require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/games_controller')
require_relative('controllers/teams_controller')
require_relative('models/data_manager')

get '/' do
  sorted_teams = DataManager.sort_by_wins()
  @sorted_teams_wins_then_goals = DataManager.sort_teams()
  erb( :index )
end
