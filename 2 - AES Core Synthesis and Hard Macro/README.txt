Part 2 README: 

Description of scripts contained in Part2/syn_045/scripts: 

synth_wrapper.tcl: Synthesizes the core.
power_estimate_wrapper_ref.tcl: Performs VCD power annotation on the core post-synthesis. 
power_estimate_wrapper_final.tcl: Performs VCD power annotation on the core post-P&R. 

To perform synthesis activities, navigate to: ENSC450finalproject/Part2/syn_045

To synthesize the core: dc_shell-xg-t -f scripts/synth.tcl
Results can be viewed in Part2/syn_045/results/aes128keyWrapper.rpt

To perform VCD power annotation, navigate to: ENSC450finalproject/Part2/syn_045

To perform VCD power annoation on post-synthesis core: 
dc_shell-xg-t -f scripts/power_estimate_wrapper_ref.tcl
Results can be viewed in Part2/syn_045/results/aes128keyWrapper_ref.vcd.rpt

To perform VCD power annoation on post-P&R core: 
dc_shell-xg-t -f scripts/power_estimate_wrapper_ref.tcl
Results can be viewed in Part2/syn_045/results/aes128keyWrapper_final.vcd.rpt

To perform place and route activities, navigate to: ENSC450finalproject/Part2/BE_045/

Launch innovus
Once the design has been imported in innovus, run the command in the innovus command line: 
source scripts/masterScript.tcl
Results can be viewed in the corresponding folders.
