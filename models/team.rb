require_relative('../db/sql_runner')

class Team

  attr_reader( :id )
  attr_accessor( :name )

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO teams(name)
    VALUES ($1)
    RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
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
