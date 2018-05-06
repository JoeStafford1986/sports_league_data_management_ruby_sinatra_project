require_relative('../db/sql_runner')

class Game

  attr_reader( :id, :team1_id, :team2_id, :result )

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @team1_id = options['team1_id'].to_i
    @team2_id = options['team2_id'].to_i
    @result = options['result']
  end

end
