transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman {D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman/bob.sv}
vlog -sv -work work +incdir+D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman {D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman/game.sv}
vlog -sv -work work +incdir+D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman {D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman/bomberman.sv}
vlog -sv -work work +incdir+D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman {D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman/HexDriver.sv}
vlog -sv -work work +incdir+D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman {D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman/player.sv}
vlib usb_system
vmap usb_system usb_system

vlog -sv -work work +incdir+D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman {D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman/game_bench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L usb_system -voptargs="+acc"  game_bench

do D:/Users/lucas/Dropbox/lucas/study/courses/ece385/final_project_local/bomberman/simulation/modelsim/wave.do
