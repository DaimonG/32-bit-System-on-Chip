# Create Floorplan (45 nm)

# floorPlan -su <aspectRatio> [<stdCellDensity> [<coreToLeft> <coreToBottom> <coreToRight> <coreToTop>]]
set defOutLefDNR 1
set defOutLefVia 1
set lefDefOutVersion 5.5

exec rm -rf temp
exec mkdir temp
exec rm -rf results
exec mkdir results
exec mkdir results/summary
exec mkdir results/timing
exec mkdir results/verilog

floorPlan -su 1  0.6 4 4 4 4   
#floorplan -d 50 50 5 5 5 5

editPin -fixedPin 1 -snap TRACK -side Top -unit TRACK -layer 2 -spreadType center -spacing 5.0 \
        -pin {resetn {input[0]} {input[1]} {input[2]} {input[3]} {input[4]} {input[5]} {input[6]} {input[7]} {input[8]} {input[9]} {input[10]} {input[11]} {input[12]} {input[13]} {input[14]} {input[15]} {input[16]} {input[17]} {input[18]} {input[19]} {input[20]} {input[21]} {input[22]} {input[23]} {input[24]} {input[25]} {input[26]} {input[27]} {input[28]} {input[29]} {input[30]} {input[31]} mr mw {keyOrPlain[0]} {keyOrPlain[1]} {keyOrPlain[2]} {keyOrPlain[3]} {keyOrPlain[4]} {keyOrPlain[5]} {keyOrPlain[6]} {keyOrPlain[7]} {keyOrPlain[8]} {keyOrPlain[9]} {keyOrPlain[10]} {keyOrPlain[11]} {keyOrPlain[12]} {keyOrPlain[13]} {keyOrPlain[14]} {keyOrPlain[15]} {keyOrPlain[16]} {keyOrPlain[17]} {keyOrPlain[18]} {keyOrPlain[19]} {keyOrPlain[20]} {keyOrPlain[21]} {keyOrPlain[22]} {keyOrPlain[23]} {keyOrPlain[24]} {keyOrPlain[25]} {keyOrPlain[26]} {keyOrPlain[27]} {keyOrPlain[28]} {keyOrPlain[29]} {keyOrPlain[30]} {keyOrPlain[31]}}
#-use TIELOW is meant to set output pinst to 0. Notice how these pins are all of type output.
editPin -fixedPin 1 -snap TRACK -side Bottom -use TIELOW -unit TRACK -layer 2 -spreadType center -spacing 10.0 \
        -pin {{cipher[0]} {cipher[1]} {cipher[2]} {cipher[3]} {cipher[4]} {cipher[5]} {cipher[6]} {cipher[7]} {cipher[8]} {cipher[9]} {cipher[10]} {cipher[11]} {cipher[12]} {cipher[13]} {cipher[14]} {cipher[15]} {cipher[16]} {cipher[17]} {cipher[18]} {cipher[19]} {cipher[20]} {cipher[21]} {cipher[22]} {cipher[23]} {cipher[24]} {cipher[25]} {cipher[26]} {cipher[27]} {cipher[28]} {cipher[29]} {cipher[30]} {cipher[31]}}

# Building a Power Ring for Vdd / Vdds, extending top/bottom segments to create pins
# From the LEF file we know that M9 and M10 are the highest metals, and that the min width of the M9 M10 metals
# is 0.8. We need to make this ring a multiple of 0.8.Since the area is small, we dont expect huge consumption,
# we keep it at pitch. 
# Note that in the foorplan we must reserve enough space between core (rows) and pins to build rings 

addRing -nets {VDD VSS} -width 0.6 -spacing 0.5 \
       -layer [list top 7 bottom 7 left 6 right 6]

#hookup the rings with stripes
addStripe -nets {VSS VDD} -layer 6 -direction vertical -width 0.4 -spacing 0.5 -set_to_set_distance 5
addStripe -nets {VSS VDD} -layer 7 -direction horizontal -width 0.4 -spacing 0.5 -set_to_set_distance 5
sroute -connect { blockPin corePin floatingStripe } -routingEffort allowShortJogs  -nets {VDD VSS}

defOut -floorplan -noStdCells results/aes128keyWrapper_floor.def
saveDesign ./DBS/03-floorplan.enc -relativePath -compress
summaryReport -outfile results/summary/03-floorplan.rpt

