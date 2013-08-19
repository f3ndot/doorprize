# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

GEOGRAPHIC_NAME = 1
SIZE_GROUP = 2
RANK = 11

population_centres = []

require 'csv'
CSV.foreach(Rails.root + "db/population_centres.csv") do |row|
  population_centres.push({ name: row[GEOGRAPHIC_NAME], rank: row[RANK] }) if row[SIZE_GROUP] != 'Small'
end

PopulationCentre.create population_centres
