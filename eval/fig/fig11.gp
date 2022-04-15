call "common.gnuplot" "3.4in, 3.9in"

set terminal postscript color
set output "fig11.eps"


mp_startx=0.1
mp_starty=0.05
mp_height=0.9
mp_rowgap=0.08
mp_colgap=0.1
mp_width=0.85

eval mpSetup(2,3)

# read
eval mpNext
unset xlabel
unset key
set ylabel 'ops/$\mu$s'
set title  '\drbl' offset 0,-1

plot \
'../data/fxmark/pmem-local:ext4:DRBL:bufferedio.dat' using 1:($2/1000000) \
 title '\ext' with lp ls ext, \
'../data/fxmark/pmem-local:pmfs:DRBL:bufferedio.dat' using 1:($2/1000000) \
 title '\pmfs' with lp ls pmfs, \
'../data/fxmark/pmem-local:nova:DRBL:bufferedio.dat' using 1:($2/1000000) \
 title '' with lp ls nova, \
'../data/fxmark/pmem-local:winefs:DRBL:bufferedio.dat' using 1:($2/1000000) \
 title '' with lp ls winefs, \
'../data/fxmark/dm-stripe:ext4:DRBL:bufferedio.dat' using 1:($2/1000000) \
 title '' with lp ls extr, \
'../data/fxmark/pm-array:odinfs:DRBL:bufferedio.dat' using 1:($2/1000000) \
 title '' with lp ls odinfs, \

eval mpNext
unset xlabel
unset ylabel
set title  '\drbm' offset 0,-1

plot \
'../data/fxmark/pmem-local:ext4:DRBM:bufferedio.dat' using 1:($2/1000000) \
 title '' with lp ls ext, \
'../data/fxmark/pmem-local:pmfs:DRBM:bufferedio.dat' using 1:($2/1000000) \
 title '' with lp ls pmfs, \
'../data/fxmark/pmem-local:nova:DRBM:bufferedio.dat' using 1:($2/1000000) \
 title '\nova' with lp ls nova, \
'../data/fxmark/pmem-local:winefs:DRBM:bufferedio.dat' using 1:($2/1000000) \
 title '\winefs' with lp ls winefs, \
'../data/fxmark/dm-stripe:ext4:DRBM:bufferedio.dat' using 1:($2/1000000) \
 title '\extr' with lp ls extr, \
'../data/fxmark/pm-array:odinfs:DRBM:bufferedio.dat' using 1:($2/1000000) \
 title '\sys' with lp ls odinfs, \

eval mpNext
unset xlabel
unset key
set title  '\drbh' offset 0,-1
set ylabel 'ops/$\mu$s'

plot \
'../data/fxmark/pmem-local:ext4:DRBH:bufferedio.dat' using 1:($2/1000000) \
 title '\ext' with lp ls ext, \
'../data/fxmark/pmem-local:pmfs:DRBH:bufferedio.dat' using 1:($2/1000000) \
 title '\pmfs' with lp ls pmfs, \
'../data/fxmark/pmem-local:nova:DRBH:bufferedio.dat' using 1:($2/1000000) \
 title '\nova' with lp ls nova, \
'../data/fxmark/pmem-local:winefs:DRBH:bufferedio.dat' using 1:($2/1000000) \
 title '\winefs' with lp ls winefs, \
'../data/fxmark/dm-stripe:ext4:DRBH:bufferedio.dat' using 1:($2/1000000) \
 title '\extr' with lp ls extr, \
'../data/fxmark/pm-array:odinfs:DRBH:bufferedio.dat' using 1:($2/1000000) \
 title '\sys' with lp ls odinfs, \

eval mpNext
unset key
unset ylabel
set title  '\dwol' offset 0,-1

plot \
'../data/fxmark/pmem-local:ext4:DWOL:bufferedio.dat' using 1:($2/1000000) \
 title '\ext' with lp ls ext, \
'../data/fxmark/pmem-local:pmfs:DWOL:bufferedio.dat' using 1:($2/1000000) \
 title '\pmfs' with lp ls pmfs, \
'../data/fxmark/pmem-local:nova:DWOL:bufferedio.dat' using 1:($2/1000000) \
 title '\nova' with lp ls nova, \
'../data/fxmark/pmem-local:winefs:DWOL:bufferedio.dat' using 1:($2/1000000) \
 title '\winefs' with lp ls winefs, \
'../data/fxmark/dm-stripe:ext4:DWOL:bufferedio.dat' using 1:($2/1000000) \
 title '\extr' with lp ls extr, \
'../data/fxmark/pm-array:odinfs:DWOL:bufferedio.dat' using 1:($2/1000000) \
 title '\sys' with lp ls odinfs, \

eval mpNext
unset key #horizontal maxrows 1 maxcolumns 5 at 0.($2/1000000), 0.95
set title  '\dwom' offset 0,-1
set ylabel 'ops/$\mu$s'

plot \
'../data/fxmark/pmem-local:ext4:DWOM:bufferedio.dat' using 1:($2/1000000) \
 title '\ext' with lp ls ext, \
'../data/fxmark/pmem-local:pmfs:DWOM:bufferedio.dat' using 1:($2/1000000) \
 title '\pmfs' with lp ls pmfs, \
'../data/fxmark/pmem-local:nova:DWOM:bufferedio.dat' using 1:($2/1000000) \
 title '\nova' with lp ls nova, \
'../data/fxmark/pmem-local:winefs:DWOM:bufferedio.dat' using 1:($2/1000000) \
 title '\winefs' with lp ls winefs, \
'../data/fxmark/dm-stripe:ext4:DWOM:bufferedio.dat' using 1:($2/1000000) \
 title '\extr' with lp ls extr, \
'../data/fxmark/pm-array:odinfs:DWOM:bufferedio.dat' using 1:($2/1000000) \
 title '\sys' with lp ls odinfs, \

eval mpNext
unset key
unset ylabel
set title  '\dwal' offset 0,-1
unset ylabel

plot \
'../data/fxmark/pmem-local:ext4:DWAL:bufferedio.dat' using 1:($2/1000000) \
 title '\ext' with lp ls ext, \
'../data/fxmark/pmem-local:pmfs:DWAL:bufferedio.dat' using 1:($2/1000000) \
 title '\pmfs' with lp ls pmfs, \
'../data/fxmark/pmem-local:nova:DWAL:bufferedio.dat' using 1:($2/1000000) \
 title '\nova' with lp ls nova, \
'../data/fxmark/pmem-local:winefs:DWAL:bufferedio.dat' using 1:($2/1000000) \
 title '\winefs' with lp ls winefs, \
'../data/fxmark/dm-stripe:ext4:DWAL:bufferedio.dat' using 1:($2/1000000) \
 title '\extr' with lp ls extr, \
'../data/fxmark/pm-array:odinfs:DWAL:bufferedio.dat' using 1:($2/1000000) \
 title '\sys' with lp ls odinfs, \
