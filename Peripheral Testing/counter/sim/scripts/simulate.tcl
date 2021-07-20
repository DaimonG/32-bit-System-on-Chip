#Simple tcl script for simulating HDL on Mentor Modelsim
#atino@sfu.ca
vsim -msgmode both counterTB
add wave -radix hex {/counterTB/clk} {/counterTB/resetn} {/counterTB/rdn} {/counterTB/wrn} {/counterTB/address} {/counterTB/data_in} {/counterTB/data_out}
restart -f ; run 500 ns

