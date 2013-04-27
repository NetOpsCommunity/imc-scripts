#! /usr/local/bin/perl

sub cleanupPartionName
{
	my($config) = @_;

	# CLI sometimes leaks in some syslog messages.. remove them _first_ [important]
	$config =~ s/(^|\n)\%.*//g; 

    #response is:
    #Directory of flash:/
    #-rwxrwxrwx   1 noone    nogroup      2785  Apr 04 2000 01:55:25   vrpcfg.txt
    #-rwxrwxrwx   1 noone    nogroup   1973145  Apr 23 2000 17:57:22   S2000-VRP310-R0023P01-h3c.app
    #3381248 bytes total (1402880 bytes free)
    #<Quidway>
    
	my $key_ = "Directory of";
    my $pos_       = index ( $config, $key_, 0 );
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
    
    return "/";
}

sub cleanupFreeSize
{
	my($config) = @_;

	# CLI sometimes leaks in some syslog messages.. remove them _first_ [important]
	$config =~ s/(^|\n)\%.*//g; 

    #response is:
    #Directory of flash:/
    #-rwxrwxrwx   1 noone    nogroup      2785  Apr 04 2000 01:55:25   vrpcfg.txt
    #-rwxrwxrwx   1 noone    nogroup   1973145  Apr 23 2000 17:57:22   S2000-VRP310-R0023P01-h3c.app
    #3381248 bytes total (1402880 bytes free)
    #<Quidway>
    
	my $key_ = "total (";
    my $pos_       = index ( $config, $key_, 0 );
    if ($pos_ != -1) {
    	my $start_ = $pos_ + length $key_;	    	
    	$config = substr( $config, $start_ );
    	
    	$key_ = "KB free";
    	$pos_       = index ( $config, $key_, 0 );
    	if ($pos_ != -1) {    		
    		$config = substr( $config, 0, $pos_);
    	}
    	
    	$config =~ s/[\r\n ]//g;
    	$config = 1024*$config;
    	return $config;
    }    
    
    return "-1";
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
	my($config) = @_;

	# CLI sometimes leaks in some syslog messages.. remove them _first_ [important]
	$config =~ s/(^|\n)\%.*//g; 

	$image_position =  removeMores($config);
	$image_position =~ s/pwd\n//;
	$image_position =  stripLastLine($image_position);
    $image_position =~ s/[\r\n ]//g;
	
	return $image_position;
}

sub cleanupImageVersion
{
	my($rawdata) = @_;

	# Remove the first line [command], along with more prompts and the last line [prompt]
	$cleandata =  removeMores($rawdata);
	$cleandata =~ s/^.*\n//;
	$cleandata =  stripLastLine($cleandata);
	
	#Boot file on flash is: flash:/ar28v300r003b04d032.bin
    $key_ = "Boot file on flash is";
	$pos_       = index ( $cleandata, $key_, 0 );
    if ($pos_ != -1) { 
        my $cleandata_ = substr( $cleandata, $pos_, (length $cleandata) - $pos_); 	
       	my $start_ = index( $cleandata_, "/",0 );	
    	my $end_ = length $cleandata_;
    	$cleandata_ = substr( $cleandata_, $start_+1, $end_ - $start_ -1);
    	$cleandata_ =~ s/[\r\n ]//g;
    	return $cleandata_;
    }
    
    #The boot file used at this reboot:cf:/msr50-cmw520-r1618p14-h3c.bin attribute:main
    my $key_ = "The boot file used at this reboot";
    my $pos_       = index ( $cleandata, $key_, 0 );
    if ($pos_ != -1) {
    	my $start_ = index($cleandata, "/",$pos_ + length $key_);	
    	my $end_ = index($cleandata,"attribute",$start_ + 1);
    	
    	$cleandata = substr( $cleandata, $start_+1, $end_ - $start_ -1);
    	$cleandata =~ s/[\r\n ]//g;
    	return $cleandata;
    }
    
    #The boot file used this time:cf:/mainar29.bin attribute: main
    $key_ = "The boot file used this time";
    $pos_       = index ( $cleandata, $key_, 0 );
    if ($pos_ != -1) {
    	my $start_ = index($cleandata, "/",$pos_ + length $key_);	
    	my $end_ = index($cleandata,"attribute",$start_ + 1);
    	
    	$cleandata = substr( $cleandata, $start_+1, $end_ - $start_-1);
    	$cleandata =~ s/[\r\n ]//g;
    	return $cleandata;
    }
	
	#The current boot app is: s4c03_03_01s168p04.app
	#The current boot app is: flash:/s3610-cmw520.bin
	$key_ = "The current boot app is:";
	$pos_       = index ( $cleandata, $key_, 0 );
    if ($pos_ != -1) {    
        my $start_ = index($cleandata, "/",$pos_ + length $key_);	
        if ($start_ == -1) {	    	
    	   $start_ = $pos_ + length $key_;
    	}
    	my $end_ = index($cleandata,"\n",$start_ +1);
    	$cleandata = substr( $cleandata, $start_ +1, $end_ - $start_ -1);    	
    	$cleandata =~ s/[\r\n ]//g;
    	return $cleandata;
    }
    
	#The primary app to boot of board 5 at this time is: flash:/s7500e-cmw520-e6611.app
	$key_ = "The primary app to boot of board";
	$pos_       = index ( $cleandata, $key_, 0 );
    if ($pos_ != -1) {    	
       	my $start_ = index($cleandata, "/",$pos_ + length $key_);	
    	my $end_ = index($cleandata,"\n",$start_ +1);
    	$cleandata = substr( $cleandata, $start_ +1, $end_ - $start_-1);
    	$cleandata =~ s/[\r\n ]//g;
    	return $cleandata;
    }
    
    #The current boot file of slot 1 is: cfa0:/s7500e-cmw520-e6611.app
	$key_ = "The current boot file of slot";
	$pos_       = index ( $cleandata, $key_, 0 );
    if ($pos_ != -1) {    	
       	my $start_ = index($cleandata, "/",$pos_ + length $key_);	
    	my $end_ = index($cleandata,"\n",$start_ +1);
    	$cleandata = substr( $cleandata, $start_ +1, $end_ - $start_-1);
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

        $start = index($config, "\# software id = ");
        if ($start == -1)
        {
                $start = 0;
        }

        $cleanConfig = substr($config, $start);

        #Re-join lines that have been split. Note some lines split at "=", others split between X=Y and A=B
        $cleanConfig =~ s/=\\\n\s*/=/;
        $cleanConfig =~ s/\s*\\\n\s*/ /g;

        #Get rid of the exec prompt at the end, and any blank lines
        $cleanConfig =~ s/\[.*\] \>.*/\n/;
        $cleanConfig =~ s/\n+$//;

        # Add a trailing newline to match file transfer results
        $cleanConfig = $cleanConfig . "\n";

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
