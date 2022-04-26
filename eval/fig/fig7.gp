call "common.gnuplot" "3.3in, 2.8in"

set terminal postscript color
set output "fig7.eps"


mp_startx=0.08
mp_starty=0.10
mp_height=0.80
mp_rowgap=0.13
mp_colgap=0.1
mp_width=0.90

eval mpSetup(2, 2)

#4k-read
eval mpNext
unset xlabel
unset key
set ylabel 'Latency ($\mu$s)'

set title '(a) 4K read-50\%'
plot \
"../data/fio/pmem-local:ext4:seq-read-4K:bufferedio.dat" \
 using 1:3 title '\ext' with lp ls ext, \
"../data/fio/pmem-local:pmfs:seq-read-4K:bufferedio.dat" \
 using 1:3 title '\pmfs' with lp ls pmfs, \
"../data/fio/pmem-local:nova:seq-read-4K:bufferedio.dat" \
 using 1:3 title '\nova' with lp ls nova, \
"../data/fio/pmem-local:winefs:seq-read-4K:bufferedio.dat" \
 using 1:3 title '\winefs' with lp ls winefs, \
"../data/fio/dm-stripe:ext4:seq-read-4K:bufferedio.dat" \
 using 1:3 title '\extr' with lp ls extr, \
"../data/fio/pm-array:odinfs:seq-read-4K:bufferedio.dat" \
 using 1:3 title '\sys' with lp ls odinfs, \

eval mpNext
unset xlabel
unset ylabel
set title '(b) 4K read-99\%'

plot \
"../data/fio/pmem-local:ext4:seq-read-4K:bufferedio.dat" \
 using 1:4 title '\ext' with lp ls ext, \
"../data/fio/pmem-local:pmfs:seq-read-4K:bufferedio.dat" \
 using 1:4 title '\pmfs' with lp ls pmfs, \
"../data/fio/pmem-local:nova:seq-read-4K:bufferedio.dat" \
 using 1:4 title '\nova' with lp ls nova, \
"../data/fio/pmem-local:winefs:seq-read-4K:bufferedio.dat" \
 using 1:4 title '\winefs' with lp ls winefs, \
"../data/fio/dm-stripe:ext4:seq-read-4K:bufferedio.dat" \
 using 1:4 title '\extr' with lp ls extr, \
"../data/fio/pm-array:odinfs:seq-read-4K:bufferedio.dat" \
 using 1:4 title '\sys' with lp ls odinfs, \

# 4k-write

eval mpNext
unset key
set xlabel '\# threads'
set ylabel 'Latency ($\mu$s)'
set title '(c) 4K write-50\%'

plot \
"../data/fio/pmem-local:ext4:seq-write-4K:bufferedio.dat" \
 using 1:3 title '\ext' with lp ls ext, \
"../data/fio/pmem-local:pmfs:seq-write-4K:bufferedio.dat" \
 using 1:3 title '\pmfs' with lp ls pmfs, \
"../data/fio/pmem-local:nova:seq-write-4K:bufferedio.dat" \
 using 1:3 title '\nova' with lp ls nova, \
"../data/fio/pmem-local:winefs:seq-write-4K:bufferedio.dat" \
 using 1:3 title '\winefs' with lp ls winefs, \
"../data/fio/dm-stripe:ext4:seq-write-4K:bufferedio.dat" \
 using 1:3 title '\extr' with lp ls extr, \
"../data/fio/pm-array:odinfs:seq-write-4K:bufferedio.dat" \
 using 1:3 title '\sys' with lp ls odinfs, \

eval mpNext
unset ylabel
unset key
set xlabel '\# threads'
set title '(d) 4K write-99\%'
#set ytics 1000

plot \
"../data/fio/pmem-local:ext4:seq-write-4K:bufferedio.dat" \
 using 1:4 title '\ext' with lp ls ext,  \
"../data/fio/pmem-local:pmfs:seq-write-4K:bufferedio.dat" \
 using 1:4 title '\pmfs' with lp ls pmfs,  \
"../data/fio/pmem-local:nova:seq-write-4K:bufferedio.dat" \
 using 1:4 title '\nova' with lp ls nova,  \
"../data/fio/pmem-local:winefs:seq-write-4K:bufferedio.dat" \
 using 1:4 title '\winefs' with lp ls winefs, \
"../data/fio/dm-stripe:ext4:seq-write-4K:bufferedio.dat" \
 using 1:4 title '\extr' with lp ls extr,  \
"../data/fio/pm-array:odinfs:seq-write-4K:bufferedio.dat" \
 using 1:4 title '\sys' with lp ls odinfs,  \

unset multiplot

