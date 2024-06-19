onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /gamePlay_testbench/timer_clk
add wave -noupdate /gamePlay_testbench/reset
add wave -noupdate /gamePlay_testbench/highScoreDisplay
add wave -noupdate /gamePlay_testbench/clearHighScore
add wave -noupdate /gamePlay_testbench/speedSW
add wave -noupdate /gamePlay_testbench/key3
add wave -noupdate /gamePlay_testbench/key2
add wave -noupdate /gamePlay_testbench/key1
add wave -noupdate /gamePlay_testbench/key0
add wave -noupdate /gamePlay_testbench/RedPixels
add wave -noupdate /gamePlay_testbench/GrnPixels
add wave -noupdate /gamePlay_testbench/hex2
add wave -noupdate /gamePlay_testbench/hex1
add wave -noupdate /gamePlay_testbench/hex0
add wave -noupdate /gamePlay_testbench/hex5
add wave -noupdate /gamePlay_testbench/hex4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1333 ps} {2541 ps}
