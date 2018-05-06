require_relative('../db/sql_runner')

class Game

  attr_reader( :id, :team1_id, :team2_id, :outcome )

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

end
