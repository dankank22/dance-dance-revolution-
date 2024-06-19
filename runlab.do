# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./DE1_SoC.sv"
#vlog "./gamePlay.sv"
#vlog "./LED_test.sv"
#vlog "./LFSR_mod.sv"
#vlog "./LFSR.sv"
#vlog "./decToHex.sv"
#vlog "./LEDDriver.sv"
#vlog "./comparator.sv"





# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
#vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench
vsim -voptargs="+acc" -t 1ps -lib work gamePlay_testbench
#vsim -voptargs="+acc" -t 1ps -lib work LED_test_testbench
#vsim -voptargs="+acc" -t 1ps -lib work LFSR_mod_testbench
#vsim -voptargs="+acc" -t 1ps -lib work LFSR_testbench
#vsim -voptargs="+acc" -t 1ps -lib work decToHex_testbench
#vsim -voptargs="+acc" -t 1ps -lib work LEDDriver_testbench
#vsim -voptargs="+acc" -t 1ps -lib work comparator_testbench


# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
