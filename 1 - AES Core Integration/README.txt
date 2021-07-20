Part 1 README:

Descriptions of all simulation scripts: 

Compilation Scripts: 
compile_wrapper.csh: Compiles the core vhdl files. 
compile_wrapper_ref.csh: Compiles the core post-synthesis. 
compule_wrapper_final.csh: Compiles the core post-P&R. 

compile_ensc450.tcsh: Compiles whole system with vhdl of core.

compile_ensc450_hard_macros.tcsh: Compiles the whole system with SRAM and Core hard macros. 
compile_ensc450_ref_hard_macros.tcsh: Compiles the whole system post-synthesis with SRAM and Core Hard macros.        
compile_ensc450_final_hard_macros.tcsh: Compiles the whole system post-P&R with SRAM and Core Hard macros. 

VCD Scripts:  
generate_vcd_wrapper_ref.tcl: Generates VCD files for the core post-synthesis.  
generate_vcd_wrapper_final.tcl: Generates VCD files for the core post-P&R. 

generate_vcd_ensc450_ref.tcl: Generates VCD files for the system post-synthesis. 
generate_vcd_ensc450_final.tcl: Generates VCD files for the system post-P&R. 
    
Simulation Scripts: 
simulate_ensc450.tcl: Simulates the entire system against tb_ensc450.vhd
simulate_wrapper.tcl: Simulates the wrapper against aes128keyWrapperTB.vhd

To perform simulations and/or generate VCD files, please navigate to: /ENSC450finalproject/Part1/sim

Compile and simulate core vhdl files: 
chmod +x scripts/compile_wrapper.csh 
./scripts/compile_wrapper.csh
Launch modelSim: vsim &
In modelSim command terminal: source scripts/simulate_wrapper.tcl

Compile and simulate core post-synthesis: 
chmod +x scripts/compile_wrapper_ref.csh 
./scripts/compile_wrapper_ref.csh
Launch modelSim: vsim &
In modelSim command terminal: source scripts/simulate_wrapper.tcl
To generate VCD: 
In modelSim command terminal: source scripts/generate_vcd_wrapper_ref.tcl

Compile and simulate core post-P&R: 
chmod +x scripts/compile_wrapper_final.csh 
./scripts/compile_wrapper_final.csh
Launch modelSim: vsim &
In modelSim command terminal: source scripts/simulate_wrapper.tcl
To generate VCD: 
In modelSim command terminal: source scripts/generate_vcd_wrapper_final.tcl

Compile and simulate system vhdl files: 
chmod +x scripts/compile_ensc450.tcsh 
./scripts/compile_ensc450.tcsh
Launch modelSim: vsim &
In modelSim command terminal: source scripts/simulate_ensc450.tcl

Compile and simulate system with SRAM and core hard macros: 
chmod +x scripts/compile_ensc450_hard_macros.tcsh 
./scripts/compile_ensc450_hard_macros.tcsh
Launch modelSim: vsim &
In modelSim command terminal: source scripts/simulate_ensc450.tcl

Compile and simulate system with SRAM and core hard macros post-synthesis: 
chmod +x scripts/compile_ensc450_ref_hard_macros.tcsh
./scripts/compile_ensc450_ref_hard_macros.tcsh
Launch modelSim: vsim &
In modelSim command terminal: source scripts/simulate_ensc450.tcl
To generate VCD: 
In modelSim command terminal: source scripts/generate_vcd_ensc450_ref.tcl

Compile and simulate system with SRAM and core hard macros post-P&R: 
chmod +x scripts/compile_ensc450_final_hard_macros.tcsh
./scripts/compile_ensc450_final_hard_macros.tcsh
Launch modelSim: vsim &
In modelSim command terminal: source scripts/simulate_ensc450.tcl
To generate VCD: 
In modelSim command terminal: source scripts/generate_vcd_ensc450_final.tcl
