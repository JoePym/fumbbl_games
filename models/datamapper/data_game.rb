class DataGame
  include DataMapper::Resource
  property :id, Serial 
  property :home_tds, Integer
  property :home_id, Integer
  property :away_id, Integer
  property :away_tds, Integer
  property :game_id, Integer
  property :home_rating, Integer
  property :away_rating, Integer
  property :home_race, String
  property :away_race, String
  property :division, Integer
  has n, :data_game_teams
  has n, :data_games, :through => :data_game_teams
end