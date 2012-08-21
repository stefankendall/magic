# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
land = Rule.find_or_create_by_name("Land")
basic = Rule.find_or_create_by_name("Basic")
forest = Rule.find_or_create_by_name("Forest")
creature = Rule.find_or_create_by_name("Creature")
elf = Rule.find_or_create_by_name("Elf")
warrior = Rule.find_or_create_by_name("Warrior")

tap_for_green = Rule.find_or_create_by_name("tap for green")

CardArchetype.find_or_create_by_name('Forest', rules: [land, basic, forest, tap_for_green])
CardArchetype.find_or_create_by_name('Elvish Warrior', rules: [creature, warrior, elf], greenCost: 2, power: 2, toughness: 3)
