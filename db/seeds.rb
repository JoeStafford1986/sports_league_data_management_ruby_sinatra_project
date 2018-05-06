require_relative( "../models/team.rb" )
require_relative( "../models/game.rb" )

require("pry-byebug")

Game.delete_all()
Team.delete_all()

team1 = Team.new({
  "name" => "Orcs",
})

team1.save()

team2 = Team.new({
  "name" => "Humans",
})

team2.save()

team3 = Team.new({
  "name" => "Dwarves",
})

team3.save()

team4 = Team.new({
  "name" => "Elves",
})

team4.save()

game1 = Game.new({
  "team1_id" => team1.id,
  "team2_id" => team2.id,
  "outcome" => "Orcs win!"
})

game1.save()

game2 = Game.new({
  "team1_id" => team3.id,
  "team2_id" => team2.id,
  "outcome" => "Dwarves win!"
})

game2.save()

game3 = Game.new({
  "team1_id" => team3.id,
  "team2_id" => team4.id,
  "outcome" => "Elves win!"
})

game3.save()

binding.pry
nil
