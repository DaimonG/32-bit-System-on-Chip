#! /bin/tcsh -f

# Creating and mapping to logic name work the local work library

echo "Compile ensc450_system"
# <Compile here your own IP>
#vcom -quiet ../vhdl/Butterfly.vhd
#vcom -quiet ../vhdl/fft_core.vhd
vlog /CMC/setups/ensc450/SOCLAB/LIBRARIES/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Verilog/NangateOpenCellLibrary.v
vlog /ensc/cmc_homedirs/escmc29/ensc450/ENSC450finalproject/Part2/BE_045/results/verilog/aes128keyWrapper.final.v
#vcom ../vhdl/aes128key.vhd
#vcom ../vhdl/aes128keyWrapper.vhd
# -------------------------
#vcom -quiet ../vhdl/SRAM_Lib/SRAM.vhd
#vcom -quiet ../vhdl/ubus.vhd
#vcom -quiet ../vhdl/dma.vhd
#vcom -quiet ../vhdl/counter.vhd
#vcom  ../vhdl/ensc450.vhd
vlog /ensc/cmc_homedirs/escmc29/ensc450/ENSC450finalproject/Part3/syn_045/results/ensc450.ref.v
vcom  ../vhdl/tb_ensc450.vhd

vopt +acc e -o E

echo ""
echo ""

