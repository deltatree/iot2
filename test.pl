#!/usr/bin/perl

use Device::SerialPort;

$port = new Device::SerialPort("/dev/ttyUSB0");
$port->baudrate(9600);
#$port->parity("none");
#$port->databits(8);
#$port->stopbits(1);
#$port->handshake("xoff");
$port->write_settings;

while (1)
{
	$bytein="";
	#$port->lookclear;

	while ($bytein eq "")
	{
	$bytein = $port->lookfor;
	die "Device::SerialPort Aborted without match\n" unless (defined $bytein);
	sleep 1;
	}

	my $data = sprintf("%s",$bytein);
	($signal_strength, $attention, $meditation, $delta, $theta, $low_alpha, $high_alpha, $low_beta, $high_beta, $low_gamma, $high_gamma) = split(",",$data);
	print $signal_strength."\n";
}

$port->close();
