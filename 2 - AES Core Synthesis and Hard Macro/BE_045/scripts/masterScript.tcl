set TIME_start [clock clicks -milliseconds]

#set init design
#set init_gnd_net VSS
#set init_lef_file /CMC/setups/ensc450/SOCLAB/LIBRARIES/NangateOpenCellLibrary_PDKv1_3_v2010_12/Back_End/lef/NangateOpenCellLibrary.lef
#set init_mmmc_file Default.view
#set init_pwr_net VDD
#set init_top_cell aes128keyWrapper
#set init_verilog inputs/aes128keyWrapper.ref.v

source scripts/03-powerPlan.tcl
source scripts/04-placement.tcl
source scripts/05-postPlaceOpt.tcl
source scripts/06-cts.tcl
source scripts/07-postCTSOpt.tcl
source scripts/08-route.tcl
source scripts/09-finishing.tcl

puts {Time to run (ms): }
set TIME_Taken [expr [clock clicks -milliseconds] - $TIME_start]
