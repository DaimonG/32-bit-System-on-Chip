if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name nangate45nm_ls\
   -timing\
    [list ${::IMEX::libVar}/lib/typ/NangateOpenCellLibrary_slow.lib\
    ${::IMEX::libVar}/lib/typ/aes128keyWrapper_slow.lib\
    ${::IMEX::libVar}/lib/typ/SRAM.lib]
create_op_cond -name pvt -library_file ${::IMEX::libVar}/lib/typ/NangateOpenCellLibrary_slow.lib -P 1 -V 1.05 -T 125
create_rc_corner -name nangate45nm_caps\
   -cap_table ${::IMEX::libVar}/mmmc/NCSU_FreePDK_45nm.capTbl\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 125
create_delay_corner -name nangate45nm_dc\
   -library_set nangate45nm_ls\
   -rc_corner nangate45nm_caps
create_constraint_mode -name ensc_cm\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/ensc_cm/ensc_cm.sdc]
create_analysis_view -name ensc_av -constraint_mode ensc_cm -delay_corner nangate45nm_dc -latency_file ${::IMEX::dataVar}/mmmc/views/ensc_av/latency.sdc
set_analysis_view -setup [list ensc_av] -hold [list ensc_av]
