call "common.gnuplot" "3.3in, 1.5in"

set terminal postscript color
set output "fig2.eps"


mp_startx=0.095
mp_starty=0.10
mp_height=0.75
mp_rowgap=0.10
mp_colgap=0.17
mp_width=0.78

eval mpSetup(2, 1)


# read
eval mpNext
set xlabel '\# threads'
set ylabel 'Bandwidth (GiB/s)'
set title '(a) read'
unset key
set ytics nomirror
set y2range [0.9:]
set y2tics
unset y2label

plot \
'../data/fio/pmem-local:ext4:seq-read-2M:bufferedio.dat' using 1:($2/1024/1024) \
 title '\ext' with lp ls ext, \
'../data/fio/pmem-local:pmfs:seq-read-2M:bufferedio.dat' using 1:($2/1024/1024) \
 title '\pmfs' with lp ls pmfs, \
'../data/fio/pmem-local:nova:seq-read-2M:bufferedio.dat' using 1:($2/1024/1024) \
 title '\nova' with lp ls nova, \
'../data/fio/pmem-local:winefs:seq-read-2M:bufferedio.dat' using 1:($2/1024/1024) \
 title '\winefs' with lp ls winefs, \
'../data/ampl_data/pmfs-2m-read.log' using 1:2 axes x1y2\
 title 'Read ampl.' with lp ls odinfs

# write
eval mpNext
unset ylabel
set title '(b) write'
set ytics nomirror
set y2range [0.9:]
set y2tics
set y2label 'Amplification rate'

plot \
'../data/fio/pmem-local:ext4:seq-write-2M:bufferedio.dat' using 1:($2/1024/1024) \
 title '\ext' with lp ls ext,\
'../data/fio/pmem-local:pmfs:seq-write-2M:bufferedio.dat' using 1:($2/1024/1024) \
 title '\pmfs' with lp ls pmfs, \
'../data/fio/pmem-local:nova:seq-write-2M:bufferedio.dat' using 1:($2/1024/1024) \
 title '\nova' with lp ls nova, \
'../data/fio/pmem-local:winefs:seq-write-2M:bufferedio.dat' using 1:($2/1024/1024) \
 title '\winefs' with lp ls winefs, \
'../data/ampl_data/pmfs-2m-write.log' using 1:2 axes x1y2\
 title 'Ampl.' with lp ls odinfs

