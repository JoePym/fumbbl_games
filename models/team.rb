class Team
  include Mongoid::Document
  has_and_belongs_to_many :games
  field :team_id
  field :division
  field :rosterId
  field :name
  
  before_create :retrieve_details
  
  def retrieve_details
    team_path = "http://fumbbl.com/xml:team?id=#{self.team_id}"
    doc = Nokogiri::XML(open(team_path))
    self.division = doc.xpath("//division").text
    self.rosterId = doc.xpath("//rosterId").text
  end
end