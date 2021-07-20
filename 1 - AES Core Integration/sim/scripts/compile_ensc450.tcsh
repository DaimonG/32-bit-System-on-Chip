#! /bin/tcsh -f

# Creating and mapping to logic name work the local work library

echo "Compile ensc450_system"
# <Compile here your own IP>
#vcom -quiet ../vhdl/Butterfly.vhd
#vcom -quiet ../vhdl/fft_core.vhd
vcom ../vhdl/aes128key.vhd
vcom ../vhdl/aes128keyWrapper.vhd
# -------------------------
vcom -quiet ../vhdl/SRAM_Lib/SRAM.vhd
vcom -quiet ../vhdl/ubus.vhd
vcom -quiet ../vhdl/dma.vhd
vcom -quiet ../vhdl/counter.vhd
vcom  ../vhdl/ensc450.vhd
vcom  ../vhdl/tb_ensc450.vhd

vopt +acc e -o E

echo ""
echo ""

