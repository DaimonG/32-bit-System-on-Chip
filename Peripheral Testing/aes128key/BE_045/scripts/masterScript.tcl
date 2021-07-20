et TIME_start [clock clicks -milliseconds]

source 03-powerPlan.tcl
source 04-placement.tcl
source 05-postPlaceOpt.tcl
source 06-cts.tcl
source 07-postCTSOpt.tcl
source 08-route.tcl
source 09-finishing.tcl

puts {Time to run (ms): }
set TIME_Taken [expr [clock clicks -milliseconds] - $TIME_start]
