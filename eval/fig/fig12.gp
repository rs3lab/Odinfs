call "common.gnuplot" "3.4in, 3.9in"

set terminal postscript color
set output "fig12.eps"

mp_startx=0.1
mp_starty=0.05
mp_height=0.9
mp_rowgap=0.1
mp_colgap=0.1
mp_width=0.80

eval mpSetup(2,3)

#4k-read
set ylabel 'KOps/sec'
eval mpNext
unset key

set title '(a) Filebench'
plot \
"../data/filebench/pmem-local:ext4:filebench_fileserver:bufferedio.dat" \
 using 1:($2/1000) title '\ext' with lp ls ext, \
"../data/filebench/pmem-local:pmfs:filebench_fileserver:bufferedio.dat" \
 using 1:($2/1000) title '\pmfs' with lp ls pmfs, \
"../data/filebench/pmem-local:nova:filebench_fileserver:bufferedio.dat" \
 using 1:($2/1000) title '\nova' with lp ls nova, \
"../data/filebench/pmem-local:winefs:filebench_fileserver:bufferedio.dat" \
 using 1:($2/1000) title '\winefs' with lp ls winefs, \
"../data/filebench/dm-stripe:ext4:filebench_fileserver:bufferedio.dat" \
 using 1:($2/1000) title '\extr' with lp ls extr, \
"../data/filebench/pm-array:odinfs:filebench_fileserver:bufferedio.dat" \
 using 1:($2/1000) title '\sys' with lp ls odinfs, \

eval mpNext
unset key
unse ylabel
set title '(b) webserver '
plot \
"../data/filebench/pmem-local:ext4:filebench_webserver:bufferedio.dat" \
 using 1:($2/1000) title '\ext' with lp ls ext, \
"../data/filebench/pmem-local:pmfs:filebench_webserver:bufferedio.dat" \
 using 1:($2/1000) title '\pmfs' with lp ls pmfs, \
"../data/filebench/pmem-local:nova:filebench_webserver:bufferedio.dat" \
 using 1:($2/1000) title '\nova' with lp ls nova, \
"../data/filebench/pmem-local:winefs:filebench_webserver:bufferedio.dat" \
 using 1:($2/1000) title '\winefs' with lp ls winefs, \
"../data/filebench/dm-stripe:ext4:filebench_webserver:bufferedio.dat" \
 using 1:($2/1000) title '\extr' with lp ls extr, \
"../data/filebench/pm-array:odinfs:filebench_webserver:bufferedio.dat" \
 using 1:($2/1000) title '\sys' with lp ls odinfs, \

set ylabel 'Throughput GiB/s'

eval mpNext
set title '(c) videoserver-read'
plot \
"../data/filebench/pmem-local:ext4:filebench_videoserver:bufferedio.dat" \
 using 1:($2/1024) title '\ext' with lp ls ext, \
"../data/filebench/pmem-local:pmfs:filebench_videoserver:bufferedio.dat" \
 using 1:($2/1024) title '\pmfs' with lp ls pmfs, \
"../data/filebench/pmem-local:nova:filebench_videoserver:bufferedio.dat" \
 using 1:($2/1024) title '\nova' with lp ls nova, \
"../data/filebench/pmem-local:winefs:filebench_videoserver:bufferedio.dat" \
 using 1:($2/1024) title '\winefs' with lp ls winefs, \
"../data/filebench/dm-stripe:ext4:filebench_videoserver:bufferedio.dat" \
 using 1:($2/1024) title '\extr' with lp ls extr, \
"../data/filebench/pm-array:odinfs:filebench_videoserver:bufferedio.dat" \
 using 1:($2/1024) title '\sys' with lp ls odinfs, \


set title '(d) videoserver-write'
set xlabel '\# threads'
unset ylabel
eval mpNext
plot \
"../data/filebench/pmem-local:ext4:filebench_videoserver:bufferedio.dat" \
 using 1:($3/1024) title '\ext' with lp ls ext, \
"../data/filebench/pmem-local:pmfs:filebench_videoserver:bufferedio.dat" \
 using 1:($3/1024) title '\pmfs' with lp ls pmfs, \
"../data/filebench/pmem-local:nova:filebench_videoserver:bufferedio.dat" \
 using 1:($3/1024) title '\nova' with lp ls nova, \
"../data/filebench/pmem-local:winefs:filebench_videoserver:bufferedio.dat" \
 using 1:($3/1024) title '\winefs' with lp ls winefs, \
"../data/filebench/dm-stripe:ext4:filebench_videoserver:bufferedio.dat" \
 using 1:($3/1024) title '\extr' with lp ls extr, \
"../data/filebench/pm-array:odinfs:filebench_videoserver:bufferedio.dat" \
 using 1:($3/1024) title '\sys' with lp ls odinfs, \


eval mpNext
set ylabel 'KOps/sec'
set xlabel '\# threads'
set title '(e) varmail' offset 0,-1
plot \
"../data/filebench/pmem-local:ext4:filebench_varmail:bufferedio.dat" \
 using 1:($2/1000) title '\ext' with lp ls ext, \
"../data/filebench/pmem-local:pmfs:filebench_varmail:bufferedio.dat" \
 using 1:($2/1000) title '\pmfs' with lp ls pmfs, \
"../data/filebench/pmem-local:nova:filebench_varmail:bufferedio.dat" \
 using 1:($2/1000) title '\nova' with lp ls nova, \
"../data/filebench/pmem-local:winefs:filebench_varmail:bufferedio.dat" \
 using 1:($2/1000) title '\winefs' with lp ls winefs, \
"../data/filebench/dm-stripe:ext4:filebench_varmail:bufferedio.dat" \
 using 1:($2/1000) title '\extr' with lp ls extr, \
"../data/filebench/pm-array:odinfs:filebench_varmail:bufferedio.dat" \
 using 1:($2/1000) title '\sys' with lp ls odinfs, \



