vsim aes128keywrappertb
restart -f
# Run Init time (Time needed to put the system in a consistent state, but that you don't want to measure. For example reset time, operand read, etc)
run 20 ns
vcd add -file aes128keyWrapper_final.vcd -r /aes128keywrappertb/uut/* 
# Run VCD time, depending on how long is the period you want to run your power analysis upon
run 660 ns
# Closes vcd file
vcd flush aes128keyWrapper_final.vcd
vcd2saif -input aes128keyWrapper_final.vcd -output aes128keyWrapper_final.vcd.saif
