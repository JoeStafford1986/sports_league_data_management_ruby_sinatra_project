require_relative('team')
require_relative('game')

class DataManager

  def self.sort_teams()
    teams = Team.all()
    sorted = teams.sort_by{|team| [team.get_wins_count(), team.get_goal_difference()]}
    return sorted.reverse()
  end

end
