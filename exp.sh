$VTUNES_CL -R hotspots -report-output MyReport.csv -format csv -csv-delimiter comma

$VTUNES_CL -report hotspots -r r001hs

$VTUNES_CL -help report <report_type>

    callstacks               Display CPU or wait time for callstacks.
    frequency-analysis       Display CPU frequency scaling time.
    gprof-cc                 Display CPU or wait time in the gprof-like format.
    gpu-computing-tasks      Display GPU computing tasks.
    hotspots                 Display CPU time.
    hw-events                Display hardware events.
    sleep-analysis           Display CPU sleep time and wake-up reasons.
    sleep-extended-analysis  
    summary                  Display data about overall performance.
    top-down                 Display a call tree for your target application and provide CPU and wait time for each function.
    vectspots     



$VTUNES_CL -R hotspots -report-output r001ah.csv -format csv -csv-delimiter comma  -r r001ah
$VTUNES_CL -R hw-events -report-output r001ah-he.csv -format csv -csv-delimiter comma  -r r001ah
$VTUNES_CL -R callstacks -report-output r001ah-c.csv -format csv -csv-delimiter comma  -r r001ah
$VTUNES_CL -R gprof-cc -report-output r002cc-gc.csv -format csv -csv-delimiter comma  -r r002cc
$VTUNES_CL -R vectspots -report-output r002cc-v.csv -format csv -csv-delimiter comma  -r r002cc
$VTUNES_CL -R hotspots -report-output r002cc-hs.csv -format csv -csv-delimiter comma  -r r002cc
$VTUNES_CL -R frequency-analysis -report-output r002cc-fa.csv -format csv -csv-delimiter comma  -r r002cc
$VTUNES_CL -R hw-events -report-output r004ge-he.csv -format csv -csv-delimiter comma  -r r004ge






















=====================================================================================
env WINEARCH=win32 WINEPREFIX=~/.wine32 winetricks msxml6

env WINEPREFIX="/home/ziyang/.wine" wine C:\\windows\\command\\start.exe /Unix /home/ziyang/.wine/dosdevices/c:/users/Public/Desktop/网易云音乐.lnk

env WINEARCH=win32 WINEPREFIX=~/.wine32 C:\\windows\\command\\start.exe /Unix /media/ziyang/OFFICE14/setup.exe
