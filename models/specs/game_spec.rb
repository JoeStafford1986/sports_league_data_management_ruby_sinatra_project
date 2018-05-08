require('minitest/autorun')
require('minitest/rg')
require_relative('../game')
require_relative('../team')

class GameTest < MiniTest::Test

  def setup
    Game.delete_all()
    Team.delete_all()

    @team1 = Team.new({
      "name" => "Orcs"
    })

    @team1.save()

    @team2 = Team.new({
      "name" => "Humans"
    })

    @team2.save()

    @game1 = Game.new({
      "team1_id" => @team1.id,
      "team2_id" => @team2.id,
      "outcome" => "Humans win!",
      "team1_score" => 0,
      "team2_score" => 1
    })

    @game1.save()

    @game2 = Game.new({
      "team1_id" => @team1.id,
      "team2_id" => @team2.id,
      "outcome" => "Orcs win!",
      "team1_score" => 1,
      "team2_score" => 0
    })

    @game2.save()

  end

  # def test_team1
  #   team_found = @game1.team1()
  #   assert_equal(Team, team_found.class)
  # end
  #
  # def test_team2
  #   team_found = @game1.team2()
  #   assert_equal(Team, team_found.class)
  # end
  #
  # def test_get_result__team2_wins
  #   assert_equal(@team2, @game1.get_result())
  # end
  #
  # def test_get_result__team1_wins
  #   assert_equal(@team1, @game2.get_result())
  # end


end
