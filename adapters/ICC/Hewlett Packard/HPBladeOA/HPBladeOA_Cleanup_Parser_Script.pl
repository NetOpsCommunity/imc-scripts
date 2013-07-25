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

	$rawdata = stripCarriageReturns($rawdata);
	$rawdata =~ s/ ?--More--[ \S]*[\s\cH]+\cH//g;
	##
	# ACNS
	$rawdata =~ s/ ?--More--[\s\cH]+|\033\[K//g;
	return $rawdata;
}

sub stripLastLine
{
	my($rawdata) = @_;
	$rawdata =~ s/\n[\S ]+\n*$//;

	return $rawdata;
}

sub cleanupConfiguration
{
	my($config) = @_;
	my(@array) = ();
	
	$start = index($config, "[");
	if ($start == -1)
	{
		$start = 0;
	}

	$stop = -1;
	$pos = -1;
	while (($pos = index($config, "End : 0", $pos)) > -1)
	{
		$stop = $pos;
		$pos++;
	}

	if ($stop > -1)
	{
		$cleanConfig = substr($config, $start, $stop-$start+8);
	}
	else
	{
		$cleanConfig = substr($config, $start);
	}

	
	# append a newline to match up with file transfer results
	$cleanConfig .= "\n";

	
	
	# Sometimes, there could be a menu which spreads the lines out
	$config = ();
	foreach $line (split(/\n/, $cleanConfig)){
		if($line =~ /^menu (\S+) title \^C(.*)/)
		{
			$line = "menu $1 title \cC$2";
		}
		elsif($line =~ /\^C$/)
		{
			$line =~ s/(\^C)$/\cC/;
		}
		
		if($line =~ /\S+ \^C/)
		{
			$line =~ s/(\S+) \^C/$1 \cC/;
		}
	
		$config = $config . $line . "\n";

	}
	
	##
	# ACNS remove CLI prompts
	$config =~ s/\n\S+>\n/\n/g;
	
	$cleanConfig = $config;

	return $cleanConfig;
}
