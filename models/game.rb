require_relative('../db/sql_runner')

class Game

  attr_reader( :id, :team1_id, :team2_id, :outcome)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @team1_id = options['team1_id'].to_i
    @team2_id = options['team2_id'].to_i
    @outcome = options['outcome']
  end

  def save()
    sql = "INSERT INTO games(team1_id, team2_id, outcome)
    VALUES ($1, $2, $3)
    RETURNING id"
    values = [@team1_id, @team2_id, @outcome]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def delete()
    sql = "DELETE FROM games
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
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
