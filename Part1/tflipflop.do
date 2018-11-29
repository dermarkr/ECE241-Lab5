
# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog main.v

#load simulation using mux as the top level simulation module
vsim tflipflop

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {clock} 0 0ns, 1 {5ns} -r 10ns

force {Reset_b} 0 
run 1 ns

force {Reset_b} 1 
run 1 ns

force {t} 1
run 20 ns 

run 50 ns
