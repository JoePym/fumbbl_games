require "./#{File.dirname(__FILE__)}/../config/initialize.rb"
require 'data_mapper'
require 'dm-migrations'
require 'dm-migrations/adapters/dm-mysql-adapter' 
DataMapper.setup(:default, 'mysql://localhost/fumbbl_games')
Dir["./#{File.dirname(__FILE__)}/../models/datamapper/*.rb"].each {|file| require file }
DataMapper.finalize
# DataMapper.auto_migrate!

# Team.all.each do |team|
#   puts "processing #{team.name}"
#   dmteam = DataTeam.create(
#     :team_id => team.team_id.to_i,
#     :division => team.division.to_i,
#     :rosterId => team.rosterId.to_i,
#     :name => team.name.to_s,
#     :roster => team.roster.to_s,
#     :game_count => team.game_count.to_i,
#     :wins => team.wins.to_i,
#     :draws => team.draws.to_i,
#     :losses => team.losses.to_i
#   )
#   next unless team.coach
#   puts "processing #{team.coach.name}"
#   dmcoach = DataCoach.first_or_create(:name => team.coach.name)
#   dmteam.data_coach = dmcoach
#   dmteam.save
# end
Game.all.each_with_index do |game, index|
  puts "processing #{index} of #{Game.count}"
  dmgame = DataGame.create(
    home_tds: game.home_tds.to_i,
    home_id: game.home_id.to_i,
    away_id: game.away_id.to_i,
    away_tds: game.away_tds.to_i, 
    game_id: game.game_id.to_i, 
    home_rating: game.home_rating.to_i, 
    away_rating: game.away_rating.to_i, 
    home_race: game.home_race.to_s, 
    away_race: game.away_race.to_s, 
    division: game.division.to_i
  )
  ht = DataTeam.get(game.home_id.to_i)
  at = DataTeam.get(game.away_id.to_i)
  DataGameTeam.create(:data_team => ht, :data_game => dmgame)
  DataGameTeam.create(:data_team => at, :data_game => dmgame)
end