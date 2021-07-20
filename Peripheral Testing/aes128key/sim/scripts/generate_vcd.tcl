vsim aes128keyTB
restart -f
# Run Init time (Time needed to put the system in a consistent state, but that you don't want to measure. For example reset time, operand read, etc)
run 20 ns
vcd add -file aes128key.vcd -r /aes128keyTB/uut/* 
# Run VCD time, depending on how long is the period you want to run your power analysis upon
run 200ns
# Closes vcd file
vcd flush aes128key.vcd
vcd2saif -input aes128key.vcd -output aes128key.vcd.saif 
