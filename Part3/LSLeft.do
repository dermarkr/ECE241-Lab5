
# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog main.v

#load simulation using mux as the top level simulation module
vsim LSLeft

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {letter[13:0]} 'b10100110111001

force {clock} 0 0ns, 1 {5ns} -r 10ns
force {reset} 0
run 1 ns
force {reset} 1
run 1 ns
force {load} 0
run 300000000 ns



force {load} 1
run 20 ns

run 1000000000 ns


