set ns [new Simulator]
set nf [open exp5.nam w]
$ns namtrace-all $nf
set tf [open exp5.tr w]
$ns trace-all $tf
proc finish {} {
	global ns nf tf
	$ns flush-trace
	close $nf
	close $tf
	exec nam exp5.nam &
	exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]


$ns duplex-link $n0 $n1 0.5MB 10ms DropTail
$ns duplex-link $n1 $n2 1MB 100ms DropTail


$ns set queue-limit $n1 $n2 5


set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1

set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1



set sink [new Agent/Null]
$ns attach-agent $n2 $sink

$ns connect $udp0 $sink
$ns connect $udp1 $sink

$cbr0 set packetSize_ 5000
$cbr0 set interval_ 0.001
$cbr1 set packetSize_ 5000
$cbr1 set interval_ 0.001


$ns at 0.1 "$cbr0 start"
$ns at 0.2 "$cbr1 start"
$ns at 4.5 "$cbr0 stop"
$ns at 4.5 "$cbr1 stop"
$ns at 5.0 "finish"

$ns run



