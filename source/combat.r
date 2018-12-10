# simulates battle:
source("roll.r", TRUE)

combat_table_enemy_file = file.path("tables", "combat_table_enemy.csv")
combat_table_pc_file = file.path("tables", "combat_table_pc.csv")

read_combat_table = function(table){
    read.table(
        table,
        sep = ";",
        stringsAsFactors = FALSE,
        header = TRUE,
        check.names = FALSE
        )
    }


combat_damage = function(pcs, ecs, roll){
    cr = pcs - ecs
    if(cr < -11) cr = -11
    if(cr > 11 ) cr = 11
    dmg_pen = combat_table_pc[as.character(roll), as.character(cr)]
    dmg_een = combat_table_enemy[as.character(roll), as.character(cr)]
    damage = c("pen"=dmg_pen, "een"=dmg_een)
    damage
    }


combat_message = function(round, roll, dmg_pen, dmg_een, pen, een){
    nchar = nchar(round)
    nchar = nchar + 7 + 1
    space = strrep(" ", nchar)

    nchar_pc = max(nchar(dmg_pen), nchar(pen))
    dmg_pen = formatC(dmg_pen, width=nchar_pc)
    pen = formatC(pen, width=nchar_pc)

    nchar_en = max(nchar(dmg_een), nchar(een))
    dmg_een = formatC(dmg_een, width=nchar_en)
    een = formatC(een, width=nchar_en)

    msg = paste0(
        "Round: ", round, " ",
        "Roll: ", roll, "\n",
        space, "Damage: ", "   ",
            "PC: ", dmg_pen, ", EN: ", dmg_een, "\n",
        space, "Remaining: ",
            "PC: ", pen, ", EN: ", een, "\n"
        )
    cat(msg)
    }


combat_round = function(pcs, pen, ecs, een, round=1){
    roll = roll()
    damage = combat_damage(pcs, ecs, roll)
    dmg_pen = damage["pen"]
    dmg_een = damage["een"]

    if(is.na(dmg_pen)){
        dmg_pen = "K"
        pen = 0
        } else {
        pen = pen - dmg_pen
        }

    if(is.na(dmg_een)){
        dmg_een = "K"
        een = 0
        } else {
        een = een - dmg_een
        }
        
    combat_message(round, roll, dmg_pen, dmg_een, pen, een)
    remaining = c(pen, een)
    names(remaining) = c("pen", "een")
    invisible(remaining)
    }


evade = function(pcs, pen, ecs, een, round=""){
    roll = roll()
    damage = combat_damage(pcs, ecs, roll)
    dmg_pen = damage["pen"]
    dmg_een = 0
    if(is.na(dmg_pen)){
        dmg_pen = "K"
        pen = 0
        } else {
        pen = pen - dmg_pen
        }
    combat_message(round, roll, dmg_pen, dmg_een, pen, een)
    if(pen < 0){
        cat(" -- You have LOST! -- \n")
        } else {
        cat(" -- Evaded! -- \n")
        }

    remaining = c(pen, een)
    names(remaining) = c("pen", "een")
    invisible(remaining)
    } 


# Simulates combat:
# pcs -- player's combat skill
# pen -- player's endurance
# ecs -- enemy's combat skill
# een -- enemy's endurance 
combat = function(pcs, pen, ecs, een){
    combat_ratio = pcs - ecs

    round = 1
    while( (pen > 0 && een > 0) ){
        remaining = combat_round(pcs, pen, ecs, een, round)
        pen = remaining["pen"]
        een = remaining["een"]
        round = round + 1
        Sys.sleep(1)
        }
    if(pen < 0){
        cat(" -- You have LOST! -- \n")
        } else {
        cat(" -- Victory! -- \n")
        }
    }


init = function(){
    combat_table_enemy = read_combat_table(combat_table_enemy_file)
    combat_table_pc = read_combat_table(combat_table_pc_file)
    assign("combat_table_enemy", combat_table_enemy, env=parent.frame())
    assign("combat_table_pc", combat_table_pc, env=parent.frame())
    }


init()
