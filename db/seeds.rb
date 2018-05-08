require_relative( "../models/team.rb" )
require_relative( "../models/game.rb" )

require("pry-byebug")

Game.delete_all()
Team.delete_all()

team1 = Team.new({
  "name" => "Orcs"
})

team1.save()

team2 = Team.new({
  "name" => "Humans"
})

team2.save()

team3 = Team.new({
  "name" => "Dwarves"
})

team3.save()

team4 = Team.new({
  "name" => "Elves"
})

team4.save()

game1 = Game.new({
  "team1_id" => team1.id,
  "team2_id" => team2.id,
  "outcome" => "Orcs win!",
  "team1_score" => 0,
  "team2_score" => 1
})

game1.save()

game2 = Game.new({
  "team1_id" => team3.id,
  "team2_id" => team2.id,
  "outcome" => "Dwarves win!",
  "team1_score" => 1,
  "team2_score" => 1
})

game2.save()

game3 = Game.new({
  "team1_id" => team3.id,
  "team2_id" => team4.id,
  "outcome" => "Elves win!",
  "team1_score" => 5,
  "team2_score" => 3
})

game3.save()
