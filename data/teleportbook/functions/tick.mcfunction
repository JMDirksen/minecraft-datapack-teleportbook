# New book when died
tag @e[type=player,scores={justdied=1..}] remove teleportbook
scoreboard players reset @e[type=player] justdied

# Give Book of Teleportation
give @a[tag=!teleportbook] written_book{pages:["[\"\",{\"text\":\"Teleport\",\"bold\":true},{\"text\":\"\\n\\n\",\"color\":\"reset\"},{\"text\":\"Home\",\"underlined\":true,\"color\":\"blue\",\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger teleportbook set 184\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Will teleport you to your spawn location or else the worldspawn (Press Esc on Credits screen)\"}},{\"text\":\"\\n\\n\",\"color\":\"reset\"},{\"text\":\"Worldspawn\",\"underlined\":true,\"color\":\"blue\",\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger teleportbook set 296\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Will teleport you to the worldspawn\"}},{\"text\":\"\\n\\n\",\"color\":\"reset\"},{\"text\":\"Random location\",\"underlined\":true,\"color\":\"blue\",\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger teleportbook set 325\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Will teleport you to a random location far away from the worldspawn\"}},{\"text\":\"\\n\\n\\n\\n\\n\\n\\n\",\"color\":\"reset\"},{\"text\":\"Teleports left?\",\"underlined\":true,\"color\":\"blue\",\"clickEvent\":{\"action\":\"run_command\",\"value\":\"/trigger teleportbook set 1\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Shows how many teleports you have left\"}}]","[\"\",{\"text\":\"About\",\"bold\":true},{\"text\":\"\\n\\nYou need teleports to be able to teleport.\\nTeleports will increase by 1 per hour with a max. of 5.\\nThere is a 1 min. cooldown after teleporting, taking damage or dealing damage.\",\"color\":\"reset\"}]"],title:"Book of Teleportation",author:"Clean Minecraft v1.1"}
scoreboard players set @a[tag=!teleportbook] teleports 5
tag @a[tag=!teleportbook] add teleportbook

# Process triggers
execute as @a[scores={teleportbook=1..}] unless entity @s[nbt={Inventory:[{id:"minecraft:written_book",tag:{title:"Book of Teleportation"}}]}] run scoreboard players reset @s teleportbook
execute as @a[scores={teleportbook=1}] run function teleportbook:teleportsleft
execute as @a[scores={teleportbook=1,cooldown=1..}] run function teleportbook:coolingdown
execute as @a[scores={teleportbook=2..,teleports=0}] run function teleportbook:noteleportsleft
execute as @a[scores={teleportbook=2..,cooldown=1..}] run function teleportbook:coolingdown
execute as @a[scores={teleportbook=184,teleports=1..}] unless score @s cooldown matches 1.. run function teleportbook:home
execute as @a[scores={teleportbook=296,teleports=1..}] unless score @s cooldown matches 1.. run function teleportbook:worldspawn
execute as @a[scores={teleportbook=325,teleports=1..}] unless score @s cooldown matches 1.. run function teleportbook:randomlocation
execute as @a[scores={teleportbook=2..,teleports=1..}] unless score @s cooldown matches 1.. run scoreboard players set @s cooldown 1200
scoreboard players reset * teleportbook
scoreboard players enable * teleportbook

# Generate "Home portal"
execute in the_end if block 0 0 0 end_portal run setblock 0 0 0 air
execute in the_end as @a[x=0,y=0,z=0,distance=..1] run setblock 0 0 0 end_portal

# Add teleports
scoreboard players add FakePlayer teleporttimer 1
execute if score FakePlayer teleporttimer matches 72000 run scoreboard players add * teleports 1
scoreboard players set @a[scores={teleports=6..}] teleports 5
execute if score FakePlayer teleporttimer matches 72000 run scoreboard players set FakePlayer teleporttimer 0

# Cooldown
scoreboard players remove @a[scores={cooldown=1..}] cooldown 1
execute as @a unless score @s lastdamagedealt = @s damagedealt run scoreboard players set @s cooldown 1200
execute as @a unless score @s lastdamagetaken = @s damagetaken run scoreboard players set @s cooldown 1200
execute as @a run scoreboard players operation @s lastdamagedealt = @s damagedealt
execute as @a run scoreboard players operation @s lastdamagetaken = @s damagetaken
execute as @a run scoreboard players operation @s cooldownsec = @s cooldown
execute as @a run scoreboard players operation @s cooldownsec /= FakePlayer twenty
