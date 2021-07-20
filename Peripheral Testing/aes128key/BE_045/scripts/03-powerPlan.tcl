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

#floorPlan -su 1  0.8  4 4 4 4   
floorplan -d 50 50 5 5 5 5

editPin -fixedPin 1 -snap TRACK -side Top -unit TRACK -layer 2 -spreadType center -spacing 5.0 \
        -pin {resetn {r[0]} {r[1]} {r[2]} {r[3]} {r[4]} {r[5]} {r[6]} {r[7]} {g[0]} {g[1]} {g[2]} {g[3]} {g[4]} {g[5]} {g[6]} {g[7]} clk {b[0]} {b[1]} {b[2]} {b[3]} {b[4]} {b[5]} {b[6]} {b[7]}}
#-use TIELOW is meant to set output pinst to 0. Notice how these pins are all of type output.
editPin -fixedPin 1 -snap TRACK -side Bottom -use TIELOW -unit TRACK -layer 2 -spreadType center -spacing 10.0 \
        -pin {{gray[0]} {gray[1]} {gray[2]} {gray[3]} {gray[4]} {gray[5]} {gray[6]} {gray[7]}}

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

defOut -floorplan -noStdCells results/rgb2gray_floor.def
saveDesign ./DBS/03-floorplan.enc -relativePath -compress
summaryReport -outfile results/summary/03-floorplan.rpt

