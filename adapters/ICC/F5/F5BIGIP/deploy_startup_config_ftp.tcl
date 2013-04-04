
#**************************************************************************
# Identification:deploy_startup_config_ftp
# Purpose:       deploy startup config via ftp
#**************************************************************************

set timeout $very_long_timeout
set DestFile "/var/local/ucs/imc_icc_f5_cfg.ucs"

ftp_trans_file false $TFTPFile $DestFile

set timeout $standard_timeout
