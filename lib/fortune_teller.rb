# frozen_string_literal: true

# SUBJECT ACTION THING TIME
# Hazel - will - get chased by - a unicorn - tomorrow
# Kiersten - will - parachute from - bees - next year

class Story
  ACTIONS = [
    "get chased by",
    "ride",
    "win",
    "eat",
    "sleep next to",
    "be eaten by",
    "buy",
    "sell",
    "call for"
  ]

  THINGS = [
    "a unicorn",
    "a squirrel",
    "bees",
    "monsters",
    "Biscuit",
    "donuts",
    "cupcakes",
    "an LOL doll",
    "a piano",
    "an octopus",
    "a turtle stool",
    "an iphone",
    "a gutiar",
    "a leaf",
    "a jack o lantern",
    "a bonsai tree",
    "a creepy doll",
    "a volcano",
    "a bird",
    "books"
  ]

  TIMES = [
    "tomorrow",
    "today",
    "next week",
    "at 5:01 pm",
    "in a while",
    "RIGHT NOW",
    "in one second",
    "tonite",
    "never",
    "at 8:16 am"
  ]

  def sentence(subject)
    action = ACTIONS.sample
    thing = THINGS.sample
    time = TIMES.sample

    "#{subject} will #{action} #{thing} #{time}."
  end
end
