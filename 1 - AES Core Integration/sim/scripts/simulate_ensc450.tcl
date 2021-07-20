vsim E 
add wave -radix hex {/e/clk} {/e/resetn} {/e/EXT_NREADY} {/e/EXT_BUSY} {/e/EXT_MR} {/e/EXT_MW} {/e/EXT_ADDRBUS} {/e/EXT_RDATABUS} {/e/EXT_WDATABUS}  {/e/holdReg}
restart -f ; run 7000 ns
