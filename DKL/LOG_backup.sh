
# Variables
SIZE_LIMIT=5		# maximim file size in MB before it is archived
DKL_NAME=$(hostname)
LOG_PATH="/home/pt/Desktop/"$DKL_NAME"_LOG.log"


LOG_SIZE=$(wc -c $LOG_PATH | awk '{print $1}')
LIMIT=$((SIZE_LIMIT*1000000))


if test $LOG_SIZE -ge $LIMIT		# Night time check
then 
	# Move files to DKL/logs folder if it exceeds size limit
	echo "$(date +"%F %T"): Log file size exceeded $SIZE_LIMIT MB. Backing up log file to home/pt/DKL/logs/"
	mkdir -p /home/pt/DKL/logs
	mv $LOG_PATH /home/pt/DKL/logs/"$DKL_NAME"_LOG_"$(date +%Y%m%d_%H%M)".log
fi