#!/bin/bash
#lzop	: http://www.lzop.org/
#p7zip	: http://sourceforge.net/projects/p7zip/files/p7zip/
#pbzip2	: http://www.compression.ca/pbzip2/
#pigz	: http://www.zlib.net/pigz/
#pixz	: https://github.com/vasi/pixz (aptitude install liblzma-dev libarchive-dev && make)
#tamp	: https://blogs.oracle.com/timc/entry/tamp_a_lightweight_multi_threaded
#zip	: http://info-zip.org/
#lz4	: https://code.google.com/p/lz4/

#sudo ./compresstest_vtunes.sh linux-4.1.3.tar 2>&1 | tee `hostname`_`date +%Y%m%d_%H%M%S`.csv


# Debugging
#set -o xtrace
#set -o verbose
# Safeguards
set -o nounset
#set -o errexit

# The script expects all programs to be in the PATH.
NAME=$1
export TMPDIR=`pwd`
THREADS=6

# Working Dir
cd /home/ziyang/Pmem/compression_benchmark
# print header
echo 'Type	Setting	Wall clock time	System time	User time	CPU	Wall clock time	System time	User time	CPU	Original size	Uncompressed size	Compressed size		md5sum'



# GZ
for block in `seq 0 9` 11
do
	echo "block"
	echo -e gz"\t"$block'%'
	sudo ./vtunes.sh "pigz --processes ${THREADS} -${block} --keep --suffix .${block}.gz ${NAME}" "rm ${NAME}.${block}.gz"
	FILE=`mktemp -u tmp.XXXXXXX.gz`
	sudo ./vtunes.sh "pigz --processes ${THREADS} --decompress --stdout ${NAME}.${block}.gz > $FILE" "rm ${NAME}.${block}.gz" "rm ${NAME}.${block}.gz" 
	stat --printf="%s\t" ${NAME} $FILE ${NAME}.${block}.gz | tr -d '\n'
	echo '%'
	md5sum $FILE | cut -f 1 -d' '
	rm $FILE
#	rm ${NAME}.${block}.gz
	echo "out of block"
done

# BZIP2
for block in `seq 1 9`
do
	echo -e bzip2"\t"$block'%'
	sudo ./vtunes.sh "pbzip2 -p${THREADS} -${block} --keep ${NAME} --stdout > ${NAME}.${block}.bz2" "rm ${NAME}.${block}.gz" 
	FILE=`mktemp -u tmp.XXXXXXX.bz2`
	sudo ./vtunes.sh "pbzip2 -p${THREADS} --decompress --stdout ${NAME}.${block}.bz2 > $FILE" "rm ${NAME}.${block}.gz" 
	stat --printf="%s\t" ${NAME} $FILE ${NAME}.${block}.bz2 | tr -d '\n'
	echo '%'
	md5sum $FILE | cut -f 1 -d' '
	rm $FILE
#	rm ${NAME}.${block}.bz2
done

# XZ
for block in `seq 0 9`
do
	echo -e xz"\t"$block'%'
	sudo ./vtunes.sh "pixz -p ${THREADS} -t -${block} -i ${NAME} -o ${NAME}.${block}.xz""rm ${NAME}.${block}.gz" 
	FILE=`mktemp -u tmp.XXXXXXX.xz`
	sudo ./vtunes.sh "pixz -p ${THREADS} -t -x -i ${NAME}.${block}.xz -o $FILE" "rm ${NAME}.${block}.gz" 
	stat --printf="%s\t" ${NAME} $FILE ${NAME}.${block}.xz | tr -d '\n'
	echo '%'
	md5sum $FILE | cut -f 1 -d' '
	rm $FILE
	rm ${NAME}.${block}.xz
done

# 7zip-lzma2
for block in 0 1
do
	echo -e 7zip-lzma2"\t"$block'%'
	sudo ./vtunes.sh "7zr a -bd -t7z -mmt=${THREADS} -mx=${block} -m0=lzma2 ${NAME}.${block}.7z ${NAME}""rm ${NAME}.${block}.gz" 
	FILE=`mktemp -u tmp.XXXXXXX.7z2`
	sudo ./vtunes.sh "7zr e -bd -so -mmt=${THREADS} ${NAME}.${block}.7z  > $FILE" "rm ${NAME}.${block}.gz" 
	stat --printf="%s\t" ${NAME} $FILE ${NAME}.${block}.7z | tr -d '\n'
	echo '%'
	md5sum $FILE | cut -f 1 -d' '
	rm $FILE
	rm ${NAME}.${block}.7z
done

# 7zip-PPMd
for block in `seq 2 32`
do
	echo -e 7zip-PPMd"\t"$block'%'
	sudo ./vtunes.sh "7z a -bd -t7z -mmt=${THREADS} -mo=${block} -m0=PPMd ${NAME}.${block}.7z ${NAME}""rm ${NAME}.${block}.gz" 
	FILE=`mktemp -u tmp.XXXXXXX.ppmd`
	sudo ./vtunes.sh "7z e -bd -so -mmt=${THREADS} ${NAME}.${block}.7z  > $FILE" "rm ${NAME}.${block}.gz" 
	stat --printf="%s\t" ${NAME} $FILE ${NAME}.${block}.7z | tr -d '\n'
	echo '%'
	md5sum $FILE | cut -f 1 -d' '
	rm $FILE
	rm ${NAME}.${block}.7z
done

# zip-deflate
for block in `seq 0 9`
do
	echo -e zip-deflate"\t"$block'%'
	sudo ./vtunes.sh "zip -${block} --quiet ${NAME}.${block}.zip ${NAME}""rm ${NAME}.${block}.gz" 
	FILE=`mktemp -u tmp.XXXXXXX.zip`
	sudo ./vtunes.sh "unzip -p ${NAME}.${block}.zip > $FILE" "rm ${NAME}.${block}.gz" 
	stat --printf="%s\t" ${NAME} $FILE ${NAME}.${block}.zip | tr -d '\n'
	echo '%'
	md5sum $FILE | cut -f 1 -d' '
	rm $FILE
	rm ${NAME}.${block}.zip
done

# 7zip-lzma
for block in 0 1
do
	echo -e 7zip-lzma"\t"$block'%'
	sudo ./vtunes.sh "7zr a -bd -t7z -mmt=${THREADS} -mx=${block} -m0=lzma ${NAME}.${block}.7z ${NAME}""rm ${NAME}.${block}.gz" 
	FILE=`mktemp -u tmp.XXXXXXX.7z`
	sudo ./vtunes.sh "7zr e -bd -so -mmt=${THREADS} ${NAME}.${block}.7z  > $FILE" "rm ${NAME}.${block}.gz" 
	stat --printf="%s\t" ${NAME} $FILE ${NAME}.${block}.7z | tr -d '\n'
	echo '%'
	md5sum $FILE | cut -f 1 -d' '
	rm $FILE
	rm ${NAME}.${block}.7z
done

# TAMP
for block in 1
do
	echo -e tamp"\t"$block'%'
	sudo ./vtunes.sh "tamp -p ${THREADS} -m ${THREADS} -i ${NAME} -o ${NAME}.${block}.q""rm ${NAME}.${block}.gz" 
	FILE=`mktemp -u tmp.XXXXXXX.tamp`
	sudo ./vtunes.sh "tamp -p ${THREADS} -m ${THREADS} -d -i ${NAME}.${block}.q -o $FILE" "rm ${NAME}.${block}.gz" 
	stat --printf="%s\t" ${NAME} $FILE ${NAME}.${block}.q | tr -d '\n'
	echo '%'
	md5sum $FILE | cut -f 1 -d' '
	rm $FILE
	rm ${NAME}.${block}.q
done

# LZOP
for block in `seq 1 9`
do
	echo -e lzop"\t"$block'%'
	sudo ./vtunes.sh "lzop -${block} -k -c ${NAME} > ${NAME}.${block}.lz""rm ${NAME}.${block}.gz" 
	FILE=`mktemp -u tmp.XXXXXXX.lzop`
	sudo ./vtunes.sh "lzop -d -c ${NAME}.${block}.lz > $FILE" "rm ${NAME}.${block}.gz" 
	stat --printf="%s\t" ${NAME} $FILE ${NAME}.${block}.lz | tr -d '\n'
	echo '%'
	md5sum $FILE | cut -f 1 -d' '
	rm $FILE
	rm ${NAME}.${block}.lz
done

# LZ4
for block in 1 9
do
	echo -e lz4"\t"$block'%'
	sudo ./vtunes.sh "lz4 -${block} -z -c ${NAME} > ${NAME}.${block}.lz4""rm ${NAME}.${block}.gz" 
	FILE=`mktemp -u tmp.XXXXXXX.lz4`
	sudo ./vtunes.sh "lz4 -d -c ${NAME}.${block}.lz4 > $FILE" "rm ${NAME}.${block}.gz" 
	stat --printf="%s\t" ${NAME} $FILE ${NAME}.${block}.lz4 | tr -d '\n'
	echo '%'
	md5sum $FILE | cut -f 1 -d' '
	rm $FILE
	rm ${NAME}.${block}.lz4
done
# Time format used:
# e      Elapsed real (wall clock) time used by the process	 in seconds.
# S      Total number of CPU-seconds used by the system on behalf of the process (in kernel mode)	 in seconds.
# U      Total number of CPU-seconds that the process used directly (in user mode)	 in seconds.
# P      Percentage of the CPU that this job got.  This is just user + system times divided by the total running time. It also prints a percentage sign.
