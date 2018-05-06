require_relative( "../models/team.rb" )
require_relative( "../models/game.rb" )

require("pry-byebug")

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
  "outcome" => "#{team1.name} win!"
})

game1.save()

game2 = Game.new({
  "team1_id" => team3.id,
  "team2_id" => team2.id,
  "outcome" => "#{team3.name} win!"
})

game2.save()

game3 = Game.new({
  "team1_id" => team3.id,
  "team2_id" => team4.id,
  "outcome" => "#{team3.name} win!"
})

game3.save()

binding.pry
nil
