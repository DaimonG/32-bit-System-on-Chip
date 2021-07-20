#Simple tcl script for simulating HDL on Mentor Modelsim
#atino@sfu.ca
vsim aes128keyWrapperTB 
add wave -radix hex {/aes128keyWrapperTB/reset} {/aes128keyWrapperTB/clock} {/aes128keyWrapperTB/input} {/aes128keyWrapperTB/cipher} {/aes128keyWrapperTB/mr} {/aes128keyWrapperTB/mw} {/aes128keyWrapperTB/keyOrPlain} {/aes128keyWrapperTB/keyCount} {/aes128keyWrapperTB/plainCount} {/aes128keyWrapperTB/uut/keyBuffer} {/aes128keyWrapperTB/uut/plainBuffer} {/aes128keyWrapperTB/uut/cipherBuffer} {/aes128keywrappertb/uut/load}
restart -f ; run 1000 ns

