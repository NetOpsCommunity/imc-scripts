
#**************************************************************************
# Identification:backup_startup_config_ftp
# Purpose:       backup startup config via ftp
#**************************************************************************

set timeout $very_long_timeout
set sourceFile "/var/local/ucs/imc_icc_f5_cfg.ucs"

ftp_trans_file true $sourceFile $TFTPFile

set timeout $standard_timeout
