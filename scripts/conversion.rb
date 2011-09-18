require "./#{File.dirname(__FILE__)}/../config/initialize.rb"

# Team.where(:division => "10").each do |t|
#   puts "Converting #{t.name}"
#   t.game_count = t.games.size
#   t.set_roster
#   t.save
# end

# Team.all.each_with_index do |t, i|
#   puts "processing #{i} of #{Team.count}"
#   next if t.coach
#   begin
#     t.retrieve_details 
#     puts t.coach.name
#   rescue
#   end
# end

Game.all.each do |g|
  g.home_tds = g.home_tds.to_i
  g.away_tds = g.away_tds.to_i
  g.teams.each do |t|
    t.set_roster
    g.division = t.division
    if g.home_id == t.team_id
      g.home_race = t.roster
    elsif g.away_id == t.team_id
      g.away_race = t.roster
    end
    t.save
  end
  g.save
  puts "#{g.home_race} #{g.home_tds} vs #{g.away_tds}#{g.away_race}"
end