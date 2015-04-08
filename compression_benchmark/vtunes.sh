#!/bin/bash
#lzop	: http://www.lzop.org/
#p7zip	: http://sourceforge.net/projects/p7zip/files/p7zip/
#pbzip2	: http://www.compression.ca/pbzip2/
#pigz	: http://www.zlib.net/pigz/
#pixz	: https://github.com/vasi/pixz (aptitude install liblzma-dev libarchive-dev && make)
#tamp	: https://blogs.oracle.com/timc/entry/tamp_a_lightweight_multi_threaded
#zip	: http://info-zip.org/
#lz4	: https://code.google.com/p/lz4/

# The script expects all programs to be in the PATH.
f=$1
Name=${f//[^[:alnum:]]/}
	echo "$f $Name"
	sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect hotspots -knob sampling-interval=10 -knob enable-user-tasks=false -knob enable-gpu-usage=false -knob enable-gpu-runtimes=false -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/compression_benchmark -- ${f} > ${Name}.hotspots_log
	${2}
	sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect advanced-hotspots -knob sampling-interval=1 -knob collection-detail=stack-call-and-tripcount -knob event-mode=all -knob enable-user-tasks=true -knob enable-gpu-usage=false -knob enable-gpu-runtimes=false -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/compression_benchmark -- ${f} > ${Name}.advanced_log
${2}
	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect concurrency -knob sampling-interval=10 -knob enable-user-tasks=true -knob enable-user-sync=true -knob enable-gpu-usage=true -knob enable-gpu-runtimes=true -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/compression_benchmark -- ${f}  > ${Name}.concurrency_log
${2}
	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect locksandwaits -knob sampling-interval=10 -knob enable-user-tasks=true -knob enable-user-sync=true -knob enable-gpu-usage=true -knob enable-gpu-runtimes=true -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/compression_benchmark -- ${f}  > ${Name}.locksandwaits_log
${2}
	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect general-exploration -knob enable-stack-collection=false -knob collect-memory-bandwidth=true -knob enable-user-tasks=false -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/compression_benchmark -- ${f} > ${Name}.memory-bandwidth_log
${2}
	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect general-exploration -knob enable-stack-collection=true -knob collect-memory-bandwidth=false -knob enable-user-tasks=false -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/compression_benchmark -- ${f}  > ${Name}.stack-collection_log
${2}
	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect general-exploration -knob enable-stack-collection=false -knob collect-memory-bandwidth=false -knob enable-user-tasks=true -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/compression_benchmark -- ${f} > ${Name}.user-tasks_log
${2}
	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect bandwidth -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/compression_benchmark -- ${f}  > ${Name}.bandwidth_log
${2}
