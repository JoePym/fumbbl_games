class Game
  include Mongoid::Document
  field :home_tds
  field :home_id
  field :away_id
  field :away_tds
  field :game_id
  field :home_rating
  field :away_rating
  field :home_race
  field :away_race
  field :division
  has_and_belongs_to_many :teams
end