require_relative('team')
require_relative('game')

class DataManager

  def self.sort_by_wins()
    teams = Team.all()
    sorted_teams = teams.sort {|team1, team2| team2.get_wins_count() <=> team1.get_wins_count()}
    return sorted_teams
  end

  def self.sort_teams()
    teams = Team.all()
    sorted = teams.sort_by{|team| [team.get_wins_count(), team.get_goal_difference()]}
    return sorted.reverse()
  end

end
