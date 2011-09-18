require "rubygems"
require "bundler/setup"

Bundler.require(:default)
require 'open-uri'
Dir["./models/*.rb"].each {|file| require file }

Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("fumbbl")
end

base_path = "http://fumbbl.com/xml:matches"
page = 1
doc = Nokogiri::XML(open(base_path + "&p=#{page}"))
#Nokogiri uses XPath as a language to step through the nodes. This is very simple to use and learn.
# while doc.xpath('//match').size > 0
in_box = true
while in_box
  doc.xpath('//match').each do |match|
    begin
      in_box = Time.parse(match.xpath("date").text) > Time.parse("2011-01-17")
      puts "Game between "  + match.xpath("home/name").text + " and " + match.xpath("away/name").text + "at " + Time.parse(match.xpath("date").text).to_s
      game = Game.find_or_create_by(:game_id => match.attributes['id'].value)
      game.home_id = match.xpath("home").first.attributes['id'].value
      game.away_id = match.xpath("away").first.attributes['id'].value
      game.home_tds = match.xpath("home/touchdowns").text
      game.away_tds = match.xpath("away/touchdowns").text
      game.home_rating = match.xpath("home/rating").text
      game.away_rating = match.xpath("away/rating").text
      home_team = Team.find_or_create_by(:team_id => game.home_id)
      home_team.name = match.xpath("home/name").text unless home_team.name
      away_team = Team.find_or_create_by(:team_id => game.away_id)
      away_team.name = match.xpath("away/name").text unless away_team.name
      home_team.games << game
      away_team.games << game
      game.save
      home_team.save
      away_team.save
    rescue
      puts page
      puts "There was an error"
    end
  end
  page += 1
  File.open("pageno", "w"){|f| f.puts page.to_s}
  doc = Nokogiri::XML(open(base_path + "&p=#{page}"))
end
#page 3534 is the last blackbox page

