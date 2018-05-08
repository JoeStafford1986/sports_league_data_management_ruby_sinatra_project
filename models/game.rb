require_relative('../db/sql_runner')
require('pry')

class Game

  attr_reader( :id )
  attr_accessor( :team1_id, :team2_id, :outcome, :team1_score, :team2_score )

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @team1_id = options['team1_id'].to_i
    @team2_id = options['team2_id'].to_i
    @outcome = options['outcome']
    @team1_score = options['team1_score'].to_i
    @team2_score = options['team2_score'].to_i
  end

  def team1()
    return Team.find(team1_id)
  end

  def team2()
    return Team.find(team2_id)
  end

  def get_result()
    if @team1_score > @team2_score
      return team1()
    else
      return team2()
    end
  end

  def save()
    sql = "INSERT INTO games(team1_id, team2_id, outcome, team1_score, team2_score)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING id"
    values = [@team1_id, @team2_id, @outcome, @team1_score, @team2_score]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def delete()
    sql = "DELETE FROM games
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE games
    SET (team1_id, team2_id, outcome, team1_score, team2_score) = ($1, $2, $3, $4, $5)
    WHERE id = $6"
    values = [@team1_id, @team2_id, @outcome, @team1_score, @team2_score, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM games"
    results = SqlRunner.run( sql )
    return results.map { |game| Game.new( game ) }
  end

  def self.find( id )
    sql = "SELECT * FROM games
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Game.new( results.first )
  end

  def self.delete_all()
    sql = "DELETE FROM games;"
    SqlRunner.run(sql)
  end

end
