
# fcampi@sfu.ca Sept 2013
# Post-Layout Power estimation with parasitics from Cadence & multiple SAIF files
#
# VCDs can be SAIF-ied with the command vcd2saif -input file.vcd -output file.vcd.saif -instance /e/uut

set search_path    "/CMC/setups/ensc450/SOCLAB/LIBRARIES/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/DB /CMC/setups/ensc450/Project/SRAM_Lib /ensc/cmc_homedirs/escmc29/ensc450/ENSC450finalproject/Part2/BE_045/results"

# Target library is the library that is used by the synthesis tool 
# in order to map the behavioral RTL logic that is being synthesized
set target_library "NangateOpenCellLibrary_slow.db"

# The synthetic library variable specified pre-designed technology independent architectures pre-packaged by Synopsys
set synthetic_library [list dw_foundation.sldb ]  

# The link library must contain ALL CELLS used in the design.cOther than the two above, it shall include any IO cell, memory cell, 
# or other cell/block that the user wishes to include in the design from other sources
set link_library  [concat $target_library SRAM.db aes128keyWrapper_slow.db $synthetic_library]

# Post-Synthesis Netlist
#read_verilog -netlist ./results/fft_core.ref.v

# Post Layout Netlist : Goodbye Wireload Models  ###################
read_verilog -netlist /ensc/cmc_homedirs/escmc29/ensc450/ENSC450finalproject/Part3/syn_045/results/ensc450.ref.v
current_design ensc450
#read_parasitics ../BE_045/results/rgb2gray.spef 
#####################################################################
#vcd2saif -input ../sim/rgb2gray.vcd -output ../sim/rgb2gray.vcd.saif -instance /e/uut
# The analysis here can be repeated indefinitely for all VCD/SAIF files available
set VCDFILES {/ensc/cmc_homedirs/escmc29/ensc450/ENSC450finalproject/Part1/sim/ensc450.vcd.saif}

foreach file $VCDFILES {
    read_saif -input $file -instance e/UUT
    report_power -analysis_effort high >> ./results/ensc450_vcd_power.rpt
}

#exit
