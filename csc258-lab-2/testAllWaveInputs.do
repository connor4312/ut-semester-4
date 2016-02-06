force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0

run 10ns

force {SW[7]} 1
force {SW[8]} 0
force {SW[9]} 0
run 10ns

force {SW[7]} 0
force {SW[8]} 1
force {SW[9]} 0
run 10ns

force {SW[7]} 1
force {SW[8]} 1
force {SW[9]} 0
run 10ns

force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 1
run 10ns

force {SW[7]} 1
force {SW[8]} 0
force {SW[9]} 1
run 10ns

force {SW[7]} 0
force {SW[8]} 1
force {SW[9]} 1
run 10ns
