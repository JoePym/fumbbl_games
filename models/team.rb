class Team
  include Mongoid::Document
  has_and_belongs_to_many :games
  field :team_id
  field :division
  field :rosterId
  field :name
  field :roster
  field :game_count, :type => Integer
  field :wins, :type => Integer
  field :draws, :type => Integer
  field :losses, :type => Integer
  belongs_to :coach
  before_create :retrieve_details
  
  def retrieve_details
    doc = self.as_xml
    self.division = doc.xpath("//division").text
    self.rosterId = doc.xpath("//rosterId").text
    tc = Coach.find_or_create_by(:name => doc.xpath("//coach").text)
    tc.teams << self
    tc.save
  end
  
  def as_xml
    team_path = "http://fumbbl.com/xml:team?id=#{self.team_id}"
    Nokogiri::XML(open(team_path))
  end
  
  def set_roster
    self.roster = case rosterId
    when "41" 
      "Amazon"
    when "42" 
      "Chaos"
    when "43" 
      "Chaos Dwarf"
    when "64" 
      "Chaos Pact"
    when "44" 
      "Dark Elf"
    when "45" 
      "Dwarf"
    when "46" 
      "Elf"
    when "47" 
      "Goblin"
    when "48" 
      "Halfling"
    when "49" 
      "High Elf"
    when "50" 
      "Human"
    when "51" 
      "Khemri"
    when "52" 
      "Lizardman"
    when "53" 
      "Necromantic"
    when "54" 
      "Norse"
    when "55" 
      "Nurgle"
    when "56" 
      "Ogre"
    when "57" 
      "Orc"
    when "58" 
      "Skaven"
    when "65" 
      "Slann"
    when "59" 
      "Undead"
    when "66" 
      "Underworld"
    when "60" 
      "Vampire"
    when "61" 
      "Wood Elf"
    end
  end
end