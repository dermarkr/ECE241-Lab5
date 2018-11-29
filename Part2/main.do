# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog main.v

#load simulation using mux as the top level simulation module
vsim main

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {CLOCK_50} 0 0ns, 1 {1ns} -r 20ns

force {reset} 1
run 1 ns

force {reset} 0
force {SW[0]} 1 
force {SW[1]} 0
run 520000000ns

force {SW[0]} 0 
force {SW[1]} 1
run 1000000000ns

force {SW[0]} 0 
force {SW[1]} 0
run 500ns