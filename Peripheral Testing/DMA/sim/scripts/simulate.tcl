#Simple tcl script for simulating HDL on Mentor Modelsim
#atino@sfu.ca
vsim -msgmode both DMA_TB 
add wave -radix hex {/DMA_TB/CLK} {/DMA_TB/reset} {/DMA_TB/M1_BUSY} {/DMA_TB/M1_MR} {/DMA_TB/M1_MW} {/DMA_TB/M1_NREADY} {/DMA_TB/M1_ADDRBUS} {/DMA_TB/M1_RDATABUS} {/DMA_TB/M1_WDATABUS} {/DMA_TB/S1_BUSY} {/DMA_TB/S1_MR} {/DMA_TB/S1_MW} {/DMA_TB/S1_NREADY} {/DMA_TB/S1_ADDRBUS} {/DMA_TB/S1_RDATABUS} {/DMA_TB/S1_WDATABUS} 
restart -f ; run 500 ns

