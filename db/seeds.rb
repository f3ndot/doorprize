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
province_map = {
  'Ont.' => 'Ontario',
  'Que.' => 'Quebec',
  'B.C.' => 'British Columbia',
  'Alta.' => 'Alberta',
  'Man.' => 'Manitoba',
  'Sask.' => 'Saskatchewan',
  'N.S.' => 'Nova Scotia',
  'N.B.' => 'New Brunswick',
  'N.L.' => 'Newfoundland and Labrador',
  'P.E.I.' => 'Prince Edward Island',
  'N.T.' => 'Northwest Territories',
  'Yuk.' => 'Yukon',
  'Nun.' => 'Nunavut',
}

require 'csv'
CSV.foreach(Rails.root + "db/population_centres.csv") do |row|
  md = row[GEOGRAPHIC_NAME].match /([^"]+)( \((.*)\))/
  if !md.nil?
    city = md[1]
    province = province_map[md[3]]
  else
    city = "FIXME - #{row[GEOGRAPHIC_NAME]}"
    province = 'FIXME'
  end
  population_centres.push({ city: city, province: province, rank: row[RANK] }) if row[SIZE_GROUP] != 'Small'
end

PopulationCentre.create population_centres
