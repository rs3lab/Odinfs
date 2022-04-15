call "common.gnuplot" "3.3in, 2.8in"

set terminal postscript color
set output "fig9.eps"

mp_startx=0.08
mp_starty=0.10
mp_height=0.80
mp_rowgap=0.13
mp_colgap=0.1
mp_width=0.90

eval mpSetup(2,2)

#4k-read
eval mpNext
unset xlabel
unset key
set ylabel 'Throughput (GiB/s)'
set title '(a) 4K read'

plot \
"../data/odinfs-4-threads/pm-array:odinfs:seq-read-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '4' with lp ls ext, \
"../data/odinfs-8-threads/pm-array:odinfs:seq-read-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '8' with lp ls extr, \
"../data/fio/pm-array:odinfs:seq-read-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '12' with lp ls nova, \
"../data/odinfs-14-threads/pm-array:odinfs:seq-read-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '14' with lp ls pmfs, \
"../data/odinfs-20-threads/pm-array:odinfs:seq-read-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '20' with lp ls odinfs, \


# 4k-write
eval mpNext
unset xlabel
unset ylabel
unset key
set title '(b) 4K write'

plot \
"../data/odinfs-4-threads/pm-array:odinfs:seq-write-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '4' with lp ls ext, \
"../data/odinfs-8-threads/pm-array:odinfs:seq-write-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '8' with lp ls extr, \
"../data/fio/pm-array:odinfs:seq-write-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '12' with lp ls nova, \
"../data/odinfs-14-threads/pm-array:odinfs:seq-write-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '14' with lp ls pmfs, \
"../data/odinfs-20-threads/pm-array:odinfs:seq-write-4K:bufferedio.dat" \
 using 1:($2/1024/1024) title '20' with lp ls odinfs, \



# 2m-read
eval mpNext
set xlabel '\# threads'
set ylabel 'Throughput (GiB/s)'
set title '(c) 2M read'

plot \
"../data/odinfs-4-threads/pm-array:odinfs:seq-read-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '4' with lp ls ext, \
"../data/odinfs-8-threads/pm-array:odinfs:seq-read-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '8' with lp ls extr, \
"../data/fio/pm-array:odinfs:seq-read-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '12' with lp ls nova, \
"../data/odinfs-14-threads/pm-array:odinfs:seq-read-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '14' with lp ls pmfs, \
"../data/odinfs-20-threads/pm-array:odinfs:seq-read-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '20' with lp ls odinfs, \



# 2m-write
eval mpNext
unset ylabel
set xlabel '\# threads'
set title '(d) 2M write'

plot \
"../data/odinfs-4-threads/pm-array:odinfs:seq-write-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '4' with lp ls ext, \
"../data/odinfs-8-threads/pm-array:odinfs:seq-write-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '8' with lp ls extr, \
"../data/fio/pm-array:odinfs:seq-write-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '12' with lp ls nova, \
"../data/odinfs-14-threads/pm-array:odinfs:seq-write-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '14' with lp ls pmfs, \
"../data/odinfs-20-threads/pm-array:odinfs:seq-write-2M:bufferedio.dat" \
 using 1:($2/1024/1024) title '20' with lp ls odinfs, \


unset multiplot

