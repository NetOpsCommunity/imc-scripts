#! /usr/local/bin/perl

sub cleanupPartionName
{
	
	  my($config) = @_;
	
	  # CLI sometimes leaks in some syslog messages.. remove them _first_ [important]
	  $config =~ s/(^|\n)\%.*//g;
	
    #only support flash 
    $config = "flash:";
    
    return $config;
}

sub cleanupFreeSize
{
	my($config) = @_;

	# CLI sometimes leaks in some syslog messages.. remove them _first_ [important]
	$config =~ s/(^|\n)\%.*//g; 

    #response is:
    #Directory of /flash/
    #
    #10/27/2010 05:10:52                       2  $$snmp_boots
    #10/14/2010 05:03:59                     716  $$sshdsspub.key
    #07/06/2015 21:22:39                   1,564  $$sshrsahost.key
    #07/06/2015 21:17:42                   3,588  $$user_profile
    #08/27/2014 01:01:10                 660,145  ___mbridge
    #10/24/2010 23:50:45                      21  boot-parameter
    #07/06/2015 21:00:50                     460  fips_public_key.crt
    #08/27/2014 00:46:25                 524,288  lp-boot-0
    #07/06/2015 21:01:39                     256  lp-mon.sig
    #07/06/2015 21:01:40                 564,163  lp-monitor-0
    #07/06/2015 21:03:17                     256  lp-pri.sig
    #07/06/2015 21:03:36               7,801,737  lp-primary-0
    #07/06/2015 21:05:06                     256  lpfpga.sig
    #07/06/2015 21:00:50                   2,898  manifest
    #07/06/2015 21:00:50                     256  manifest.sig
    #07/06/2015 21:01:13                 537,647  monitor
    #07/06/2015 21:01:12                     256  monitor.sig
    #07/06/2015 21:02:37               9,651,771  primary
    #07/06/2015 21:02:10                     256  primary.sig
    #07/17/2015 07:41:05                   1,426  startup-config
    #
    #                20 File(s)       19,751,962 bytes
    #                 0 Dir(s)         7,864,320 bytes free
    #SSH@MLXb#

	my $key_ = "Dir(s)";
    my $pos_       = index ( $config, $key_, 0 );
    if ($pos_ != -1) {
    	my $start_ = $pos_ + length $key_;	    	
    	$config = substr( $config, $start_ );
    	
    	$key_ = "bytes free";
    	$pos_       = index ( $config, $key_, 0 );
    	if ($pos_ != -1) {    		
    		$config = substr( $config, 0, $pos_);
    	}
    	
    	$config =~ s/[\r\n ]//g;
    	return $config;
    }    
    
    return "-1";
}

sub cleanupImageSize
{
	my($config) = @_;

	# cmd resp is as follow:
	#dir bootflash:cat4000-i5s-mz.122-20.EWA-icc.bin
    #Directory of bootflash:/cat4000-i5s-mz.122-20.EWA-icc.bin
    #
    # 1  -rwx    12468240  May 19 2010 08:48:09 +00:00  cat4000-i5s-mz.122-20.EWA-icc.bin
    #
    #61341696 bytes total (48872396 bytes free)
    #
    #Switch#
    
    #remove syslog
	$config =~ s/(^|\n)\%.*//g; 

	my $key_ = "-rw-";
    my $pos_       = index ( $config, $key_, 0 );
    if ($pos_ != -1) {
    	my $start_ = $pos_ + length $key_;	    	
    	$config = substr( $config, $start_+1);
    	$config =~ s/\s+//; 
    	
    	$pos_ = index ( $config, " ", 0 );
    	$config = substr( $config, 0, $pos_);
    	$config =~ s/\s+//g; 
     	print "\n",$config;  	    	
    	return $config;
    }
    
    $key_ = "-rwx";
    $pos_       = index ( $config, $key_, 0 );
    if ($pos_ != -1) {
    	my $start_ = $pos_ + length $key_;	    	
    	$config = substr( $config, $start_+1);
    	$config =~ s/\s+//; 
    	
    	$pos_ = index ( $config, " ", 0 );
    	$config = substr( $config, 0, $pos_);
    	$config =~ s/\s+//g; 
     	print "\n",$config;  	    	
    	return $config;
    }
		
	return -1;
}

sub cleanupImagePosition
{
	my($rawdata) = @_;

	# Remove the first line [command], along with more prompts and the last line [prompt]
	$cleandata =  removeMores($rawdata);
	$cleandata =~ s/^.*\n//;
	$cleandata =  stripLastLine($cleandata);

    # System image file is "bootflash:cat4000-i5s-mz.122-20.EWA-icc.bin"
    # System image file is "flash:/tmp/c2960-lanbase-mz.122-26.SEE6.bin"
    my $key_ = "\"";
    my $pos_       = index ( $cleandata, $key_, 0 );
    if ($pos_ != -1) {
    	my $start_ = $pos_ + length $key_ + 1;	
       	my $end_ = index ( $cleandata, "\"", $start_ );
       	
       	$cleandata = substr( $cleandata, $start_ , $end_ - $start_);    
       	
    	$pos_       = index ( $cleandata, "/", 0);
    	my $tmp_ = $pos_;
    	while ($pos_ != -1) {
    	    $tmp_ = $pos_;
    	    $pos_ = index($cleandata, "/",$pos_ + 1);	
    	}
    	    	    	
    	if ($tmp_ == -1) {
    	 	$end_ = index($cleandata, ":",0);	
    	}
    	else {
    		$end_ = $tmp_;
    	}
    	
    	$cleandata = substr( $cleandata, 0 , $end_);      	
    	$cleandata =~ s/[\r\n ]//g;    	    	
    	return $cleandata;
    }
    
    return $cleandata;
}

sub cleanupImageVersion
{
	my($rawdata) = @_;

	# Remove the first line [command], along with more prompts and the last line [prompt]
	$cleandata =  removeMores($rawdata);
	$cleandata =~ s/^.*\n//;
	$cleandata =  stripLastLine($cleandata);

    # System image file is "bootflash:cat4000-i5s-mz.122-20.EWA-icc.bin"
    # System image file is "flash:/c2960-lanbase-mz.122-26.SEE6.bin"
    my $key_ = "System image file is";
    my $pos_       = index ( $cleandata, $key_, 0 );
    if ($pos_ != -1) {
    	my $start_ = index($cleandata, ":",$pos_ + length $key_);	
    	my $end_ = index($cleandata,"\n",$start_ + 1);
    	
    	$cleandata = substr( $cleandata, $start_ +1 , $end_ - $start_ -2);  
    	$pos_       = index ( $cleandata, "/", 0 );
    	if ($pos_ != -1) {
    		my $len_ = length($cleandata) - $pos_ -1;
    		$cleandata = substr($cleandata, $pos_ +1 , $len_);  
    	}  	   	
    	$cleandata =~ s/[\r\n ]//g;    	    	
    	return $cleandata;
    }
    
    return $cleandata;
}

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
	
	$start = index($config, "\nver");
	if ($start == -1)
	{
		$start = 0;
	}

	$stop = -1;
	$pos = -1;
	while (($pos = index($config, "end", $pos)) > -1)
	{
		$stop = $pos;
		$pos++;
	}

	if ($stop > -1)
	{
		$cleanConfig = substr($config, $start, $stop-$start+3);
	}
	else
	{
		$cleanConfig = substr($config, $start);
	}

	$cleanConfig = removeMores($cleanConfig);

	# append a newline to match up with file transfer results
	$cleanConfig .= "\n";

	# and make sure any ^C sequences wrapping banners are converted
	# to ASCII 3 (\cC) characters

	# using a loop since the global tag doesn't work for this
	while ($cleanConfig =~ s/\nbanner([\S ]+?)\^C(.*?)\^C\n(\!|(banner))/\nbanner$1\cC$2\cC\n$3/s)
	{
		# do nothing
	}
	while ($cleanConfig =~ s/\nmenu([\S ]+?)\^C(.*?)\^C\n(\!|menu|banner)/\nmenu$1\cC$2\cC\n$3/s)
	{
		# do nothing
	}
	while ($cleanConfig =~ s/\n(aaa authentication banner )([\S ]+?)\^C(.*?)\^C\n(\!|menu|banner)/\n$1$2\cC$3\cC\n$4/s)
	{
		# do nothing
	}
	
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
	$config =~ s/\n\S+#\n/\n/g;
	
	$cleanConfig = $config;

	return $cleanConfig;
}

sub cleanupTFTPConfiguration
{
	my($config) = @_;

	$start = index($config, "!");
	if ($start == -1)
	{
		$start = 0;
	}

	return substr($config, $start);
}

sub cleanupVersion
{
	my($rawdata) = @_;
	
	$start = index($rawdata, "Version");
	$cleandata = substr($rawdata, $start);
	$stop = index($cleandata, ",");
	$cleandata = substr($rawdata, 0,$stop);
	#$cleandata = removeMores($cleandata);
	#$cleandata = stripLastLine($cleandata);

	return $cleandata;
}

sub getTarValue
{
	my ($config) = @_;
	my $value = "false";

	if($config =~ /\S+\.tar/)
	{
		$value = "true";
	}

	return $value;
}

sub getBootValue
{
	my ($config) = @_;
	my $value = "false";

	if($config =~ /\S+boot\S+/)
	{
		$value = "true";
	}

	return $value;
}

sub getDeploymentParsingSuccess
{
	my ($config) = @_;
	my $value = "true";

	if($config =~ /% Invalid input detected at/)
	{
		$value = "false";
	}

	return $value;
}
