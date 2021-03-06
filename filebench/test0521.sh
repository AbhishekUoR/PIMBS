cd /home/ziyang/Pmem/redis
#-target-duration-type=short
for f in run-Bench.sh run-Bench1.sh run-Bench2.sh run-Bench3.sh run-Bench4.sh
do
	echo $f
	sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect hotspots -knob sampling-interval=10 -knob enable-user-tasks=false -knob enable-gpu-usage=false -knob enable-gpu-runtimes=false -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/redis -- /home/ziyang/Pmem/redis/${f} > ${f}.hotspots_log

	sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect advanced-hotspots -knob sampling-interval=1 -knob collection-detail=stack-call-and-tripcount -knob event-mode=all -knob enable-user-tasks=true -knob enable-gpu-usage=false -knob enable-gpu-runtimes=false -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/redis -- /home/ziyang/Pmem/redis/${f} > ${f}.advanced_log

	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect concurrency -knob sampling-interval=10 -knob enable-user-tasks=true -knob enable-user-sync=true -knob enable-gpu-usage=true -knob enable-gpu-runtimes=true -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/redis -- /home/ziyang/Pmem/redis/${f}  > ${f}.concurrency_log

	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect locksandwaits -knob sampling-interval=10 -knob enable-user-tasks=true -knob enable-user-sync=true -knob enable-gpu-usage=true -knob enable-gpu-runtimes=true -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/redis -- /home/ziyang/Pmem/redis/${f}  > ${f}.locksandwaits_log

	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect general-exploration -knob enable-stack-collection=false -knob collect-memory-bandwidth=true -knob enable-user-tasks=false -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/redis -- /home/ziyang/Pmem/redis/${f} > ${f}.memory-bandwidth_log

	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect general-exploration -knob enable-stack-collection=true -knob collect-memory-bandwidth=false -knob enable-user-tasks=false -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/redis -- /home/ziyang/Pmem/redis/${f}  > ${f}.stack-collection_log

	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect general-exploration -knob enable-stack-collection=false -knob collect-memory-bandwidth=false -knob enable-user-tasks=true -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/redis -- /home/ziyang/Pmem/redis/${f} > ${f}.user-tasks_log

	 sudo /opt/intel/vtune_amplifier_xe_2015.3.0.403110/bin64/amplxe-cl -collect bandwidth -follow-child -mrte-mode=auto -duration 900 -no-allow-multiple-runs -no-analyze-system -data-limit=500 -slow-frames-threshold=40 -fast-frames-threshold=100 -no-analyze-kvm-guest -app-working-dir /home/ziyang/Pmem/redis -- /home/ziyang/Pmem/redis/${f}  > ${f}.bandwidth_log
done
