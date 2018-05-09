require_relative('team')
require_relative('game')

class Statistic

  def self.sort_by_wins()
    teams = Team.all()
    sorted_teams = teams.sort {|team1, team2| team2.get_wins_count() <=> team1.get_wins_count()}
    return sorted_teams
  end
  #
  # def self.sort_by_goal_difference(teams)
  #   sorted_teams_by_goals = teams
  #   sorted_teams_by_goals = teams.sort do |team1, team2|
  #     team2.get_goal_difference() <=> team1.get_goal_difference()
  #   end
  #   return sorted_teams_by_goals
  # end
  def self.sort_by_goal_difference(teams)
    sorted_teams_by_goals = teams
    sorted_teams_by_goals = teams.sort_ do |team1, team2|
      if team1.get_wins_count() == team2.get_wins_count()
        team2.get_goal_difference() <=> team1.get_goal_difference()
      end
    end
    return sorted_teams_by_goals
  end

  def self.sort_teams()
    teams = Team.all()
    sorted = teams.sort_by{|team| [team.get_wins_count(), team.get_goal_difference() ]}
  end

end
