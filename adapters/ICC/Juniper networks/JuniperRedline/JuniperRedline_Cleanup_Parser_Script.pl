#! /usr/local/bin/perl

sub stripCarriageReturns
{
	my($rawdata) = @_;

	$rawdata =~ s/[\r\x80\xC0]//g;

	return $rawdata;
}

sub removeMores
{
	my($rawdata) = @_;

	$rawdata =~ s/\[\=More \(\d+\%\)\=\]\r +\r//g;
	$rawdata = stripCarriageReturns($rawdata);

	return $rawdata;
}

sub stripLastLine
{
	my($rawdata) = @_;

	$rawdata =~ s/\n*$//;
	$rawdata =~ s/[\S\t ]+$//;
	
	return $rawdata;
}

sub cleanupConfiguration
{
	my($config) = @_;

	$config = removeMores($config);
	
	if ($config !~ /set[\S ]+?\n*$/)
	{
		$config = stripLastLine($config);
	}
	$config =~ s/^[\S\s]*?(\# Juniper Networks)/$1/;
	# NOTE: intentionally set up to skip opening # Juniper comment line
	$config =~ s/\n#.*//g;

	return $config;
}