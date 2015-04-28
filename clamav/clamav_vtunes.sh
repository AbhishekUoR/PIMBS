#!/bin/bash
#lzop	: http://www.lzop.org/
#p7zip	: http://sourceforge.net/projects/p7zip/files/p7zip/
#pbzip2	: http://www.compression.ca/pbzip2/
#pigz	: http://www.zlib.net/pigz/
#pixz	: https://github.com/vasi/pixz (aptitude install liblzma-dev libarchive-dev && make)
#tamp	: https://blogs.oracle.com/timc/entry/tamp_a_lightweight_multi_threaded
#zip	: http://info-zip.org/
#lz4	: https://code.google.com/p/lz4/

#clamav$ sudo clamscan --tempdir=/tmp -r /home/ziyang/Pmem/

# Debugging
#set -o xtrace
#set -o verbose
# Safeguards
#                 set -o nounset
#set -o errexit

# The script expects all programs to be in the PATH.
THREADS=6

# Working Dir
cd /media/35df8274-2b37-4a8a-a9e7-654ece61e83c/home/ziyang/Pmem/glimpse-4.18.6
sudo sh glimpse_vtunes.sh 

cd /home/ziyang/Pmem/clamav


#sudo ./vtunes1.sh "glimpseindex  /home/ziyang/Pmem/compression_benchmark/linux-4.1.3/" ""

for block in  "/mnt/pmfs/" "/tmp/"
do
	for Name in  "/home/ziyang/Pmem/" "/home/ziyang/Pmem/compression_benchmark/linux-4.1.3/"
	do
		(echo "linux-4.1.3 $block$Name" | tr '-' '_' | tr '.' '_' | tr '/' '_')
		  echo "$block"
     
		sudo ./vtunes1.sh "sudo clamscan --tempdir=${block} -r ${Name}" "" > ${block}/$(echo "Pmem${block}${Name}" | tr ' ' '_' | tr '-' '_' | tr '.' '_' | tr '/' '_').log
#rm -rf ${block}/.glimpse_*
	done
	echo "out of block"
done

# Time format used:
# e      Elapsed real (wall clock) time used by the process	 in seconds.
# S      Total number of CPU-seconds used by the system on behalf of the process (in kernel mode)	 in seconds.
# U      Total number of CPU-seconds that the process used directly (in user mode)	 in seconds.
# P      Percentage of the CPU that this job got.  This is just user + system times divided by the total running time. It also prints a percentage sign.
