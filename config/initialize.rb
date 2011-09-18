require "rubygems"
require "bundler/setup"

Bundler.require(:default)
require 'open-uri'
Dir["#{File.dirname(__FILE__)}/../models/*.rb"].each {|file| require file }

Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("fumbbl")
end

RACES = [ "Amazon","Chaos","Chaos Dwarf","Chaos Pact","Dark Elf" ,"Dwarf" ,"Elf" ,"Goblin","Halfling","High Elf","Human","Khemri",
          "Lizardman","Necromantic","Norse","Nurgle","Ogre","Orc","Skaven" ,"Slann","Undead","Underworld","Vampire","Wood Elf"]