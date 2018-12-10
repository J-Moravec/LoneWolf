# Lone Wolf companion
I used to play Lone Wolf when I was little. But combat and some other stuff was always so bothersome. Recently I have found [https://www.projectaon.org/en/Main/Books] where you can find lone wolf books in PDF or HTML format, so I have created this `R` code to make combat a little bit easier. Its not perfect, its not a fully automated thing that tracks your HP, items and gold. But for that, you would need something where the books would exist inside of it, not on side. Which would make it a little bit inflexible.

## How to use:
Run your `R` interactive session and type just source `LoneWolf.r`
```r
  source(LoneWolf.r)
```

Now you have access to following functions:

* `fight(pc_skill, pc_endurance, enemy_skill, enemy_endurance)` for a full fledged combat simulation
* `evade(pc_skill, pc_endurance, enemy_skill, enemy_endurance)` for when you can run from combat
* `roll()` a simple 0 to 9 random number generation
* `newchar(file)` will create a new randomly generated character as specified file

You also have access to the `combat` and `character` modules.
