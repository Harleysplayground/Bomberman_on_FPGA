onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /game_bench/clk
add wave -noupdate /game_bench/reset
add wave -noupdate -radix unsigned /game_bench/game1/over
add wave -noupdate -radix hexadecimal /game_bench/keycode
add wave -noupdate -radix unsigned /game_bench/game1/command
add wave -noupdate -radix unsigned /game_bench/playerX
add wave -noupdate -radix unsigned /game_bench/playerY
add wave -noupdate -radix unsigned /game_bench/game1/bomb_state
add wave -noupdate -radix unsigned /game_bench/game1/bomb_x
add wave -noupdate -radix unsigned /game_bench/game1/bomb_y
add wave -noupdate /game_bench/game1/map
add wave -noupdate -radix unsigned /game_bench/game1/monsterX
add wave -noupdate -radix unsigned /game_bench/game1/monsterY
add wave -noupdate -radix unsigned /game_bench/game1/pre_monsterX
add wave -noupdate -radix unsigned /game_bench/game1/pre_monsterY
add wave -noupdate /game_bench/game1/monster_command
add wave -noupdate -radix unsigned /game_bench/game1/monster_counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3059 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 276
configure wave -valuecolwidth 110
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {29314 ps}
