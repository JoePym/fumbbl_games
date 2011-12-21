#This scenario builds a chart of home race against away race

#You need this line, it sets up all the database and loads everything for you.
require "./#{File.dirname(__FILE__)}/../config/initialize.rb"


data = {}
box_games = Game.where(:division => "10")
puts box_games.count.inspect
current_bracket = [box_games.asc(:home_rating).last.home_rating, box_games.asc(:away_rating).last.away_rating].max

while current_bracket > 0
  data[current_bracket] ||= {}
  games = box_games.where(:home_rating.lte => current_bracket, :home_rating.gte => current_bracket - 25)
  puts games.count
  games.each do |game|
    data[current_bracket][game.home_race] ||= {}
    data[current_bracket][game.away_race] ||= {}
    data[current_bracket][game.away_race][game.home_race] ||= {}
    data[current_bracket][game.home_race][game.away_race] ||= {}
    data[current_bracket][game.home_race][game.away_race][:total] ||= 0
    data[current_bracket][game.away_race][game.home_race][:total] ||= 0
    data[current_bracket][game.home_race][game.away_race][:wins] ||= 0
    data[current_bracket][game.away_race][game.home_race][:wins] ||= 0    
    data[current_bracket][game.home_race][game.away_race][:total]  += 1
    data[current_bracket][game.away_race][game.home_race][:total] += 1
    if game.home_tds > game.away_tds
      data[current_bracket][game.home_race][game.away_race][:wins] += 1
    elsif game.home_tds == game.away_tds
      data[current_bracket][game.home_race][game.away_race][:wins] += 0.5
      data[current_bracket][game.away_race][game.home_race][:wins] += 0.5
    elsif game.away_tds > game.home_tds
      data[current_bracket][game.away_race][game.home_race][:wins] += 1
    end
  end
  current_bracket -= 25
end
data.each do |bracket, team_information|
  File.open("./#{File.dirname(__FILE__)}/../output/team_comparison/#{bracket}.html", "w") do |f|
    f << "<html><head></head><body><table>"
    f << "<thead><th></th>"
    RACES.each do |race|
      f << "<th>#{race}</th>"
    end
    f << "</thead>"
    RACES.each do |row_race|
      f << "<tr><td>#{row_race}</td>"
      RACES.each do |col_race|
        unless team_information[row_race] && team_information[row_race][col_race]
          f << "<td class='noData'></td>"
        else
          wins = team_information[row_race][col_race][:wins]
          total = team_information[row_race][col_race][:total]
          percentage = ((wins.to_f/total.to_f)*100).to_i
          red_distance = (16*((100 - percentage.to_f)/100)).to_i.to_s(16)
          green_distance = (16*((percentage.to_f)/100)).to_i.to_s(16)
          if percentage.to_i == 0
            red_distance = "F"
            green_distance = "0"
          elsif percentage.to_i == 100
            red_distance = "0"
            green_distance = "F"
          end
          background_color = red_distance*2 + green_distance*2 + "66"
          f << "<td style='background-color:##{background_color}'>#{percentage}% <sub>#{total}</sub></td>"
        end
      end
      f << "</tr>"
    end
    f << "</table></body></html>"
  end
end