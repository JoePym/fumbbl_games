class Coach
  include Mongoid::Document

  has_many :teams
  field :name
end