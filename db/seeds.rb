require_relative( "../models/team.rb" )

require("pry-byebug")

team1 = Team.new({
  "name" => "Orcs",
})

team1.save()
