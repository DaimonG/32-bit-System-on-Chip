Part 3 README

Description of scripts contained in Part3/syn_045/scripts: 

synth_ensc450.tcl: Synthesizes the entire system with SRAM and CORE hard macros. 
power_estimate_ensc450_ref.tcl: Performs VCD power annotation on the system post-synthesis. 
power_estimate_ensc450_final.tcl: Performs VCD power annotation on the system post-P&R. 

To perform synthesis activities, navigate to: ENSC450finalproject/Part3/syn_045
To synthesize the core: dc_shell-xg-t -f scripts/synth_ensc450.tcl
Results can be viewed in Part3/syn_045/results/ensc450.rpt

To perform VCD power annotation, navigate to: ENSC450finalproject/Part3/syn_045

To perform VCD power annoation on post-synthesis core: 
dc_shell-xg-t -f scripts/power_estimate_ensc450_ref.tcl
Results can be viewed in Part3/syn_045/results/ensc450_ref.vcd.rpt

To perform VCD power annoation on post-P&R core: 
dc_shell-xg-t -f scripts/power_estimate_ensc450_ref.tcl
Results can be viewed in Part3/syn_045/results/ensc450_final.vcd.rpt

To perform place and route activities, navigate to: ENSC450finalproject/Part3/BE_045/
Launch innovus
Once the design has been imported in innovus, run the command in the innovus command line: 
source scripts/masterScript.tcl
Results can be viewed in the corresponding folder.
