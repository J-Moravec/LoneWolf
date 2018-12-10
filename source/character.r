# this module will create random character:

roll = function(){
    sample(0:9, 1)
    }


create = function(file="LoneWolf.txt", disciplines=10){
    combat_skill_roll = roll()
    combat_skill = combat_skill_roll + 10

    endurance_roll = roll()
    endurance = endurance_roll + 20

    cat("Combat skill roll: ", combat_skill_roll, "\n")
    cat("Endurance roll: ", endurance_roll, "\n")

    if(disciplines > 10){
        disciplines = 10
        }
    if(disciplines < 10){
        sample = sort(sample(1:10, disciplines))
        kai_disciplines = kai_disciplines_list()[sample]
        } else {
        kai_disciplines = kai_disciplines_list()
        }

    kai_disciplines = kai_disciplines_formatter(kai_disciplines)
    random_item = random_item()
    equipment = equipment(random_item)


    cat("Random item: ", random_item$name, "\n")


    msg = paste0(
        "# Character Sheet #\n",
        "Combat skill: ", combat_skill, "\n",
        "Endurance: ", endurance,
        if(random_item$name == "Chainmal"){
            paste0(" (", endurance+4, " with Chainmal)")
            },
        if(random_item$name == "Helmet"){
            paste0(" (", endurance+2, " with Helmet)")
            },
        "\n",
        "\n",
        "## Kai disciplines ##\n",
        if(disciplines == 10){ "(pick 5 and delete the rest)\n" },
        kai_disciplines, "\n",
        "## Equipment ##\n",
        equipment, "\n"
        )
    cat(msg, file=file)
    }


random_item = function(){
    random_item_list = random_item_list()
    roll = sample(1:10, 1)
    random_item_list[[roll]]
    }


random_item_list = function(){
    list(
        list(type="Weapons", name="Sword"),
        list(type="Special", name="Helmet", description="+2 to max EN"),
        list(type="Meals", name="2 Meals"),
        list(type="Special", name="Chainmal", description="+4 to max EN"),
        list(type="Weapons", name="Mace"),
        list(type="Backpack", name="Healing potion", description="+4 EN when used"),
        list(type="Weapons", name="Quarterstaff"),
        list(type="Weapons", name="Spear"),
        list(type="Gold", name="12 Gold Crowns"),
        list(type="Weapons", name="Broadsword")
        )
    }

equipment = function(random_item){
    gold_roll = roll()
    cat("Gold roll:", gold_roll, "\n")
    msg = paste0(
        "Weapons (max 2 items):\n",
        "Axe\n",
        if(random_item$type == "Weapons"){
            paste0(random_item$name, "\n")}, "\n",
        "Backpack (max 8 items):\n",
        if(random_item$type == "Meals"){"3 Meals\n"} else {"1 Meal\n"},
        if(random_item$type == "Backpack"){
            paste0(random_item$name, " -- ", random_item$description, "\n")
            }, "\n",
        "Belt pouch:\n",
        if(random_item$type == "Gold"){
            paste0(12 + gold_roll, " Gold Crowns\n")
            } else {
            paste0(gold_roll, " Gold Crowns\n")
            }, "\n",
        "Special items:\n",
        if(random_item$type == "Special"){
            paste0(random_item$name, " -- ",random_item$description, "\n")
            }, "\n"
        )
    msg
    }


kai_disciplines_formatter = function(list){
    text = paste0(
        "* ", names(list), "\n",
        "   ", list, "\n"
        , collapse="")
    text
    }


random_weapon = function(){
    roll = roll()
    weapon = weapon_list()[as.character(roll)]
    weapon
    }


weapon_list = function(){
    weapons = c(
        "Dagger", "Spear", "Mace", "Short Sword", "Warhammer",
        "Sword", "Axe", "Sword", "Quarterstaff", "Broadsword"
        )
    names(weapons) = as.character(0:9)
    weapons
    }


kai_disciplines_list = function(){
    random_weapon = random_weapon()
    cat("Weaponskill mastery:", random_weapon, "\n")
    list(
        "Cammouflage" =
        "help remaining undetected in nature and cities",

        "Hunting" =
        "no nead for MEAL when instructed to eat",

        "Sixth Sense" =
        "warns against imminent danger",

        "Tracking" =
        "helps making correct choices of paths in wild and cities",

        "Healing" =
        "+1 EN for each section without combat",

        "Weaponskill" =
        paste0("+2 CS with ", random_weapon),

        "Mindshield" =
        "no points lost when attacked by Mindblast",

        "Mindblast" =
        "+2 CS unless target is immune",

        "Animal Kinship" =
        "enable communication with some animals",

        "Mind Over Matter" =
        "can move small objects with mind"
        )
    }
