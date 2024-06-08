#Filename: sample1.tcl

#TCL – Tool Command Language

# Simulator Instance Creation
set ns [new Simulator]

if {$argc != 1} {
    error "\nCommand: ns sample3.tcl <no.of.nodes>\n\n "
}

#Fixing the co-ordinate of simutaion area
set val(x) 500
set val(y) 500
# Define options
set val(chan) Channel/WirelessChannel ;# channel type
set val(prop) Propagation/TwoRayGround ;# radio-propagation model

set val(netif) Phy/WirelessPhy ;# network interface type
set val(mac) Mac/802_11 ;# MAC type
set val(ifq) Queue/DropTail/PriQueue ;# interface queue type
set val(ll) LL ;# link layer type
set val(ant) Antenna/OmniAntenna ;# antenna model
set val(ifqlen) 50 ;# max packet in ifq
set val(nn) [lindex $argv 0] ;# number of mobilenodes
set val(rp) AODV ;# routing protocol
set val(x) 500 ;# X dimension of topography
set val(y) 400 ;# Y dimension of topography
set val(stop) 10.0 ;# time of simulation end

# set up topography object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

#Nam File Creation nam – network animator
set namfile [open sample1.nam w]

#Tracing all the events and cofiguration
$ns namtrace-all-wireless $namfile $val(x) $val(y)

#Trace File creation
set tracefile [open sample1.tr w]

#Tracing all the events and cofiguration
$ns trace-all $tracefile

# general operational descriptor- storing the hop details in the network
create-god $val(nn)

# configure the nodes
$ns node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace OFF \
-movementTrace ON

#***************Dynamic Wireless network **********************#

#******************Random Topology Creation********************#

#Run Time Argument

array set node_array {}

#Random Location for nodes

for {set i 0} {$i < $val(nn)} {incr i} {
    # Create a new node and store it in the array
    set node_array($i) [$ns node]

    # Set the color of the node
    $node_array($i) color black

    #Randomly assign node positions
    $node_array($i) set X_ [expr rand()*$val(x)]
    $node_array($i) set Y_ [expr rand()*$val(y)]
    $node_array($i) set Z_ 0

    $ns initial_node_pos $node_array($i) 30
}

#Size of the node
# ending nam and the simulation
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "stop"

#Stopping the scheduler
$ns at 10.01 "puts \"end simulation\" ; $ns halt"
#$ns at 10.01 "$ns halt"
proc stop {} {
global namfile tracefile ns
$ns flush-trace
close $namfile
close $tracefile
#executing nam file
exec nam sample1.nam &
}

#Starting scheduler
$ns run