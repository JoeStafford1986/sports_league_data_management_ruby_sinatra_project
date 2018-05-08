require_relative('../db/sql_runner')
require_relative('game')

class Team

  attr_reader( :id )
  attr_accessor( :name )

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def get_wins_count()
    total_wins = 0
    games = Game.all()
    for game in games
      winner = game.get_winner()
      if @id == winner.id
        total_wins += 1
      end
    end
    return total_wins
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
    return total_losses
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

  def self.sort_by_wins()
    teams = Team.all()
    sorted_teams = teams.sort {|team1, team2| team2.get_wins_count() <=> team1.get_wins_count()}
    return sorted_teams
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
