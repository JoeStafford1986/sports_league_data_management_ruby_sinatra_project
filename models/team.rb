require_relative('../db/sql_runner')
require_relative('game')
require_relative('data_manager')

class Team

  attr_reader( :id )
  attr_accessor( :name )

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def get_league_position()
    league_position = 0
    sorted_teams = DataManager.sort_teams()
    for team in sorted_teams
      if team.id == id
        league_positon = sorted_teams.find_index(team) + 1
      end
    end
    return league_positon
  end

  def get_goal_difference()
    goal_difference = 0
    goal_difference += get_total_goals_scored()
    goal_difference -= get_total_goals_conceded()
    return goal_difference
  end

  def get_opponent_scored_against_most()
    sorted_teams = DataManager.sort_teams()
    opponent_scored_against_most = sorted_teams.first()
    for team in sorted_teams
      if get_total_goals_scored_against(team) >= get_total_goals_scored_against(opponent_scored_against_most)
        opponent_scored_against_most = team
      end
    end
    return opponent_scored_against_most
  end

  def get_opponent_conceded_against_most()
    sorted_teams = DataManager.sort_teams()
    opponent_conceded_against_most = sorted_teams.first()
    for team in sorted_teams
      if get_total_goals_conceded_against(team) >= get_total_goals_conceded_against(opponent_conceded_against_most)
        opponent_conceded_against_most = team
      end
    end
    return opponent_conceded_against_most
  end

  def get_total_goals_scored()
    games = Game.all()
    total_goals_scored = 0
    for game in games
      if game.team1_id == @id
        total_goals_scored += game.team1_score.to_i
      elsif game.team2_id == @id
        total_goals_scored += game.team2_score.to_i
      end
    end
    return total_goals_scored.to_i
  end

  def get_total_goals_conceded()
    games = Game.all()
    total_goals_conceded = 0
    for game in games
      if game.team1_id == @id
        total_goals_conceded += game.team2_score.to_i
      elsif game.team2_id == @id
        total_goals_conceded += game.team1_score.to_i
      end
    end
    return total_goals_conceded.to_i
  end

  def get_total_goals_scored_against(opponent)
    games = Game.all()
    total_goals_scored_against = 0
    for game in games
      if game.team1_id == @id && game.team2_id == opponent.id
        total_goals_scored_against += game.team1_score
      elsif game.team2_id == @id && game.team1_id == opponent.id
        total_goals_scored_against += game.team2_score
      end
    end
    return total_goals_scored_against
  end

  def get_total_goals_conceded_against(opponent)
    games = Game.all()
    total_goals_conceded_against = 0
    for game in games
      if game.team1_id == @id && game.team2_id == opponent.id
        total_goals_conceded_against += game.team2_score
      elsif game.team2_id == @id && game.team1_id == opponent.id
        total_goals_conceded_against += game.team1_score
      end
    end
    return total_goals_conceded_against
  end

  def get_opponent_won_against_most()
    sorted_teams = DataManager.sort_teams()
    opponent_won_against_most = sorted_teams.first()
    for team in sorted_teams
      if get_wins_against_opponent(team) >= get_wins_against_opponent(opponent_won_against_most)
        opponent_won_against_most = team
      end
    end
    return opponent_won_against_most
  end

  def get_opponent_lost_against_most()
    sorted_teams = DataManager.sort_teams()
    opponent_lost_against_most = sorted_teams.first()
    for team in sorted_teams
      if get_losses_against_opponent(team) >= get_losses_against_opponent(opponent_lost_against_most)
        opponent_lost_against_most = team
      end
    end
    return opponent_lost_against_most
  end

  def get_wins_against_opponent(opponent)
    total_wins_against_opponent = 0
    games = Game.all()
    for game in games
      winner = game.get_winner()
      loser = game.get_loser()
      if @id == winner.id && opponent.id == loser.id
        total_wins_against_opponent += 1
      end
    end
    return total_wins_against_opponent
  end

  def get_losses_against_opponent(opponent)
    total_losses_against_opponent = 0
    games = Game.all()
    for game in games
      winner = game.get_winner()
      loser = game.get_loser()
      if @id == loser.id && opponent.id == winner.id
        total_losses_against_opponent += 1
      end
    end
    return total_losses_against_opponent
  end

  def get_wins_count()
    total_wins = 0
    games = Game.all()
    for game in games
      winner = game.get_winner()
      # binding.pry
      if @id == winner.id
        total_wins += 1
      end
    end
    return total_wins.to_i
  end

  def get_losses_count()
    total_losses = 0
    games = Game.all()
    for game in games
      loser = game.get_loser()
      if @id == loser.id
        total_losses += 1
      end
    end
    return total_losses.to_i
  end

  def self.sort_alphabetically()
    teams = Team.all()
    sorted_teams = teams.sort_by {|team| team.name.downcase }
    return sorted_teams
  end

  def save()
    sql = "INSERT INTO teams(name)
    VALUES ($1)
    RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def delete()
    sql = "DELETE FROM teams
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE teams
    SET name = $1
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def games()
    sql = "SELECT * FROM games
    WHERE team1_id = $1
    OR team2_id = $1"
    values = [@id]
    games_data = SqlRunner.run(sql, values)
    games = games_data.map { |game| Game.new( game ) }
    return games
  end

  def self.all()
    sql = "SELECT * FROM teams"
    results = SqlRunner.run( sql )
    return results.map { |team| Team.new( team ) }
  end

  def self.find( id )
    sql = "SELECT * FROM teams
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Team.new( results.first )
  end

  def self.delete_all()
    sql = "DELETE FROM teams;"
    SqlRunner.run(sql)
  end

end
