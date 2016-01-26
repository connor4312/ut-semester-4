# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all verilog modules in mux.v to working dir;
# could also have multiple verilog files.
vlog mux.v

# Load simulation using mux as the top level simulation module.
vsim mux

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}


# test cases for selecting SW 0:
    force {SW[0]} 1
    force {SW[1]} 0
    force {SW[2]} 0
    force {SW[3]} 0

    # expect HI LO LO LO
    do testAllWaveInputs.do

# test cases for selecting SW 1:
    force {SW[0]} 0
    force {SW[1]} 1
    force {SW[2]} 0
    force {SW[3]} 0

    # expect LO LO HI LO
    do testAllWaveInputs.do

# test cases for selecting SW 2:
    force {SW[0]} 0
    force {SW[1]} 0
    force {SW[2]} 1
    force {SW[3]} 0

    # expect LO HI LO LO
    do testAllWaveInputs.do

# test cases for selecting SW 3:
    force {SW[0]} 0
    force {SW[1]} 0
    force {SW[2]} 0
    force {SW[3]} 1

    # expect LO LO LO HI
    do testAllWaveInputs.do

