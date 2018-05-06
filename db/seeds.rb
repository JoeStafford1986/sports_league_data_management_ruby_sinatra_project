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

game1 = Game.new({
  "team1_id" => team1.id,
  "team2_id" => team2.id,
  "outcome" => "#{team1.name} win!"
})

game1.save()

binding.pry
nil
