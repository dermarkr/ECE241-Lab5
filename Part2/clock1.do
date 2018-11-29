# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog main.v

#load simulation using mux as the top level simulation module
vsim clock1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}



force {clock} 0 0ns, 1 {5ns} -r 20ns

force {reset} 0
run 1 ns
force {reset} 1
run 1 ns
force {reset} 0
run 1 ns

run 2000000000 ns


