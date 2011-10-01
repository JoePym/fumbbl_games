class DataCoach
  include DataMapper::Resource
  property :id,         Serial    # An auto-increment integer key
  property :name,      String    # A varchar type string, for short strings
  has n, :data_teams
end