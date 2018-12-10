source("source/module.r")

# importing modules:
combat = module("source/combat.r")
character = module("source/character.r")

# importing some functions into environment
fight = combat$combat
evade = combat$evade
roll = combat$roll
newchar = character$new
