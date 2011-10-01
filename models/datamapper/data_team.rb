class DataTeam
  include DataMapper::Resource
  property :id, Serial
  property :team_id, Integer
  property :division, Integer
  property :rosterId, Integer
  property :name, String
  property :roster, String
  property :game_count, Integer
  property :wins, Integer
  property :draws, Integer
  property :losses, Integer

  belongs_to :data_coach

  has n, :data_game_teams
  has n, :data_teams, :through => :data_game_teams
end
