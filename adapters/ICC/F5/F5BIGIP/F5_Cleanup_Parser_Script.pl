#! /usr/local/bin/perl

sub cleanupPartionName
{
	my($rawdata) = @_;

    my $keyWord = "-----------------------------------------";
    my $pos = index($rawdata,$keyWord);
    if (-1 != $pos) {
        $rawdata = substr($rawdata,$pos);
    }
    
	my $PartionList = "";
	
    my $colVolume = -1;
    my $colActive = -1;
    my @lines = split /^/,$rawdata;
    for $i (0..$#lines) {
        my @columns = split " ",$lines[$i];
        if (($colVolume == -1) && ($colActive == -1)) {
            for $j (0..$#columns) {
                if ($columns[$j] eq "Volume") {
                    $colVolume = $j;
                } elsif ($columns[$j] eq "Active") {
                    $colActive = $j;
                }
            }
        } else {
            if ($columns[$colActive] eq "no") {
                if ($PartionList eq "") {
                    $PartionList = $columns[$colVolume];
                } else {
                    $PartionList = $PartionList."^_^".$columns[$colVolume];
                }
            }
        }
    }

    if ($PartionList eq "") {
        return "/";
    }
    
    return $PartionList;
}

sub cleanupFreeSize
{
	my($rawdata) = @_;

	my $dfResp = "";
	my $softwareResp = "";
    my $keyWord = "-----------------------------------------";
    my $pos = index($rawdata,$keyWord);
    if (-1 != $pos) {
        $dfResp = substr($rawdata,0,$pos);
        $softwareResp = substr($rawdata,$pos);
    }

    my $freeSize = -1;
    my @dfLines = split /^/,$dfResp;
    for $i (0..$#dfLines) {
        my @dfColumns = split " ",$dfLines[$i];
        if (($#dfColumns >= 2) && ($dfColumns[$#dfColumns] eq "/shared")) {
            $freeSize = $dfColumns[$#dfColumns-2] * 1024;
            if ($freeSize > 4294967295) {
                $freeSize = 4294967295;
            }
        }
        
    }

	my $FreeSizeList = "";

    my $colVolume = -1;
    my $colActive = -1;
    my @lines = split /^/,$softwareResp;
    for $i (0..$#lines) {
        my @columns = split " ",$lines[$i];
        if (($colVolume == -1) && ($colActive == -1)) {
            for $j (0..$#columns) {
                if ($columns[$j] eq "Volume") {
                    $colVolume = $j;
                } elsif ($columns[$j] eq "Active") {
                    $colActive = $j;
                }
            }
        } else {
            if ($columns[$colActive] eq "no") {
                if ($FreeSizeList eq "") {
                    $FreeSizeList = $freeSize;
                } else {
                    $FreeSizeList = $FreeSizeList."^_^".$freeSize;
                }
            }
        }
    }
    return $FreeSizeList;
}

sub cleanupBoardNumber
{
	my($config) = @_;
	    
    #remove syslog
	$config =~ s/(^|\n)\%.*//g; 

    #The primary app to boot of board 5 at this time is: flash:/s7500e-v6r6b2d088.app
    #The primary app to boot of board 0 at this time is: flash:/s7600_v8r1_rmi-63sp18.app
    
	my $key_ = "The primary app to boot of board";
    my $pos_       = index ( $config, $key_, 0 );
    if ($pos_ != -1) {
    	my $start_ = $pos_ + length $key_;	    	
    	$config = substr( $config, $start_+1);
    	
    	$key_ = "at this time";
    	$pos_       = index ( $config, $key_, 0 );
    	if ($pos_ != -1) {    		
    		$config = substr( $config, 0, $pos_);
    	}
    	
    	$config =~ s/[\r\n ]//g;	    	
    	return $config;
    }    
    
    $key_ = "Slot";   
	$pos_       = index ( $config, $key_, 0 );
	if ($pos_ != -1) {
		my $start_ = $pos_ + length $key_;	    	
    	$config = substr( $config, $start_+1);
    	
    	$key_ = "\n";
    	$pos_       = index ( $config, $key_, 0 );
    	if ($pos_ != -1) {    		
    		$config = substr( $config, 0, $pos_);
    	}
    	
    	$config =~ s/[\r\n ]//g;	    	
    	return $config;
	}
		
	return 1;
}

sub cleanupStartupConfigurationFileName
{
	my($config) = @_;
	my($config1) = @_;
	    
    #remove syslog
	$config =~ s/(^|\n)\%.*//g; 

	my $key_ = "saved-configuration file:";
    my $pos_       = index ( $config, $key_, 0 );
    if ($pos_ != -1) {
    	my $start_ = $pos_ + length $key_;	    	
    	$config = substr( $config, $start_+1);
    	
    	$key_ = "Next";
    	$pos_       = index ( $config, $key_, 0 );
    	if ($pos_ != -1) {    		
    		$config = substr( $config, 0, $pos_);
    	}
    	
    	$config =~ s/[\r\n ]//g;
    	
    	if ($config eq "NULL") {
    		$key_ = "Next startup saved-configuration file:";
		    $pos_       = index ( $config1, $key_, 0 );
		    if ($pos_ != -1) {
		    	my $start_ = $pos_ + length $key_;	    	
		    	$config1 = substr( $config1, $start_+1);
		    	
		    	$key_ = "\n";
		    	$pos_       = index ( $config1, $key_, 0 );
		    	if ($pos_ != -1) {    		
		    		$config1 = substr( $config1, 0, $pos_);
		    	}
		    	
		    	$config1 =~ s/[\r\n ]//g;		    			    	    	
		    	return $config1;
		    }    
		    
		    $key_ = "Next main startup saved-configuration file:";
		    $pos_       = index ( $config1, $key_, 0 );
		    if ($pos_ != -1) {
		    	my $start_ = $pos_ + length $key_;	    	
		    	$config1 = substr( $config1, $start_+1);
		    	
		    	$key_ = "\n";
		    	$pos_       = index ( $config1, $key_, 0 );
		    	if ($pos_ != -1) {    		
		    		$config1 = substr( $config1, 0, $pos_);
		    	}
		    	
		    	$config1 =~ s/[\r\n ]//g;		    			    	    	
		    	return $config1;
		    }    
    	}	   
    	 	
    	return $config;
    }    
		
	return $config;
}

sub cleanupImageSize
{
	my($config) = @_;

	# cmd resp is as follow:
	#<iCC>dir cf:/msr50-cmw520-r1618p14-h3c.bin
    #Directory of cf:/
    #
    #0     -rw-  13994404  May 20 2010 16:49:16   msr50-cmw520-r1618p14-h3c.bin
    #
    #252908 KB total (230988 KB free)
    #
    #File system type of cf: FAT16
    #
    #<iCC>
    
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

    my $colVolume = -1;
    my $colActive = -1;
    my @lines = split /^/,$rawdata;
    for $i (0..$#lines) {
        my @columns = split " ",$lines[$i];
        if (($colVolume == -1) && ($colActive == -1)) {
            for $j (0..$#columns) {
                if ($columns[$j] eq "Volume") {
                    $colVolume = $j;
                } elsif ($columns[$j] eq "Active") {
                    $colActive = $j;
                }
            }
        } else {
            if ($columns[$colActive] eq "yes") {
                return $columns[$colVolume];
            }
        }
    }

    return "";
}

#&cleanupImageVersion;
sub cleanupImageVersion
{
	my($rawdata) = @_;

    my $colVersion = -1;
    my $colActive = -1;
    my @lines = split /^/,$rawdata;
    for $i (0..$#lines) {
        my @columns = split " ",$lines[$i];
        if (($colVersion == -1) && ($colActive == -1)) {
            for $j (0..$#columns) {
                if ($columns[$j] eq "Version") {
                    $colVersion = $j;
                } elsif ($columns[$j] eq "Active") {
                    $colActive = $j;
                }
            }
        } else {
            if ($columns[$colActive] eq "yes") {
                return $columns[$colVersion];
            }
        }
    }
    
    return "";
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
	$rawdata =~ s/  ---- More ----(\x1b\[\d+n)*\x1b\[\d+D +\x1b\[\d+D//g;
    $rawdata =~ s/ ---- More ----(\s)*//g;
	return $rawdata;
}

sub stripLastLine
{
	my($rawdata) = @_;

	$rawdata =~ s/\n+$//;
	$rawdata =~ s/[\S ]*?$//;
	$rawdata =~ s/\n+$//;
	
	return $rawdata;
}

sub cleanupConfiguration
{
	my($config) = @_;

	# CLI sometimes leaks in some syslog messages.. remove them _first_ [important]
	$config =~ s/(^|\n)\%.*//g; 

	$cleanConfig =  removeMores($config);
	$cleanConfig =~ s/display current-configuration\n//;
	$cleanConfig =  stripLastLine($cleanConfig);

	# Add a leading newline to match file transfer results
	$cleanConfig = "\n".$cleanConfig;

	# This driver requires that deployed configurations contain \r\n's
	$cleanConfig =~ s/\n/\r\n/g;

	return $cleanConfig;
}

sub cleanupStartupConfiguration
{ 
	my($config) = @_;

	# CLI sometimes leaks in some syslog messages.. remove them _first_ [important]
	$config =~ s/(^|\n)\%.*//g; 

	$cleanConfig = removeMores($config);
	$cleanConfig = stripLastLine($cleanConfig);

	# Look for the "more" command that indicates the start of the actual data file
	$start       = index ( $cleanConfig, "more", 0 );
	$cleanConfig = substr( $cleanConfig, $start );

	# Remove the "more" command line and any leading blanks/blank lines
	$cleanConfig =~ s/more (\S+)\s+//;

	# CLI sometimes leaks in some syslog messages.. remove them
	$cleanConfig =~ s/(^|\n)\%.*//g;

	# This driver requires that deployed configurations contain \r\n's
	$cleanConfig =~ s/\n/\r\n/g;

	return $cleanConfig;
}

sub cleanupTFTPConfiguration
{
	my($config) = @_;

	$config = stripCarriageReturns( $config );

	# Saved configs [TFTP] seems to add several "#" comment lines that are not
	# in the configuration [display current-configuration]. Remove them now.
	# [Don't remove blank "#" lines... since these are in both]
	$config =~ s/\n#\S.*//g;

	# Remove trailing spaces ... seems to be added by "save" operation preceeding TFTP
	$config =~ s/ +\n/\n/g;

	# This driver requires that deployed configurations contain \r\n's
	$config =~ s/\n/\r\n/g;

	return $config;
}

sub cleanupVersion
{
	my($rawdata) = @_;

	# Remove the first line [command], along with more prompts and the last line [prompt]
	$cleandata =  removeMores($rawdata);
	$cleandata =~ s/^.*\n//;
	$cleandata =  stripLastLine($cleandata);

	# Make a nice header for the serial number information
	$cleandata =~ s/\n\S+> *display device manuinfo/\n%%% DISPLAY DEVICE MANUINFO %%%/;

	return $cleandata;
}

sub cleanupInventory
{
	my($rawdata) = @_;

	# Remove the first line [command], along with more prompts and the last line [prompt]
	$cleandata =  removeMores($rawdata);
	$cleandata =~ s/^.*\n//;
	$cleandata =  stripLastLine($cleandata);

	# Make a nice header for the serial number information
	$cleandata =~ s/\n\S+> *display device manuinfo/\n%%% DISPLAY DEVICE MANUINFO %%%/;

	return $cleandata;
}
