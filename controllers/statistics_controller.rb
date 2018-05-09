require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/statistic.rb' )
require_relative( '../models/game.rb' )
require_relative( '../models/team.rb' )

get '/stats' do
  sorted_teams = Statistic.sort_by_wins()
  # binding.pry
  #@sorted_teams_by_goal_difference = Statistic.sort_by_goal_difference(sorted_teams)
  @sorted_teams_by_goal_difference = Statistic.sort_teams
  # binding.pry
  erb( :"statistics/index")
end
