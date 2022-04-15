call "common.gnuplot" "3.3in, 2.8in"

set terminal postscript color
set output "fig10.eps"


# set multiplot layout 2,2

mp_startx=0.08
mp_starty=0.10
mp_height=0.80
mp_rowgap=0.13
mp_colgap=0.1
mp_width=0.90

eval mpSetup(2,2)

#4k-read
eval mpNext
unset key
unset xlabel
set ylabel 'Throughput (GiB/s)'
set title '(a) 4K read'

plot \
"../data/odinfs-1-sockets/pm-array:odinfs:seq-read-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '1' with lp ls ext, \
"../data/fio/pm-array:odinfs:seq-read-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '2' with lp ls pmfs, \


# 4k-write
eval mpNext
unset key
unset xlabel

plot \
"../data/odinfs-1-sockets/pm-array:odinfs:seq-write-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '1' with lp ls ext, \
"../data/fio/pm-array:odinfs:seq-write-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '2' with lp ls pmfs, \




# 2m-read
eval mpNext
unset key
set xlabel '\# threads'
set ylabel 'Throughput (GiB/s)'
set title '(c) 2M read'

plot \
"../data/odinfs-1-sockets/pm-array:odinfs:seq-read-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '1 PM domain' with lp ls ext, \
"../data/fio/pm-array:odinfs:seq-read-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '2 PM domains' with lp ls pmfs, \



# 2m-write
eval mpNext
unset ylabel
set xlabel '\# threads'
set title '(d) 2M write'

plot \
"../data/odinfs-1-sockets/pm-array:odinfs:seq-write-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '' with lp ls ext, \
"../data/fio/pm-array:odinfs:seq-write-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '' with lp ls pmfs, \


unset multiplot

