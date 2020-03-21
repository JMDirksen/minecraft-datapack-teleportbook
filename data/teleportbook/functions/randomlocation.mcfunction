scoreboard players remove @s teleports 1
summon armor_stand 0 1 0 {Tags:[spread],NoGravity:1,Invisible:1,Invulnerable:1}
tag @s add spread
spreadplayers 0 0 5000 10000 false @e[tag=spread]
tag @s remove spread
kill @e[type=armor_stand,tag=spread]
function teleportbook:teleportsleft
