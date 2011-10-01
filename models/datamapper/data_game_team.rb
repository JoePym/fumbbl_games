class DataGameTeam
  include DataMapper::Resource
  property :id, Serial
  belongs_to :data_game
  belongs_to :data_team
end