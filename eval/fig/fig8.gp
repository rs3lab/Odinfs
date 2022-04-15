call "common.gnuplot" "3.3in, 1.5in"

set terminal postscript color
set output "fig8.eps"

mp_startx=0.10
mp_starty=0.10
mp_height=0.75
mp_rowgap=0.10
mp_colgap=0.06
mp_width=0.88

eval mpSetup(2, 1)


# read
eval mpNext
set xlabel '\# threads'
set ylabel 'IO amplification'
set yrange [0.9:]
set title '(a) 2M read'
unset key

plot \
'../data/ampl_data/ext4-2m-read.log' using 1:2 \
 title '\ext' with lp ls ext, \
'../data/ampl_data/pmfs-2m-read.log' using 1:2 \
 title '\pmfs' with lp ls pmfs, \
'../data/ampl_data/nova-2m-read.log' using 1:2 \
 title '\nova' with lp ls nova, \
'../data/ampl_data/winefs-2m-read.log' using 1:2 \
 title '\winefs' with lp ls winefs, \
'../data/ampl_data/odinfs-2m-read.log' using 1:2 \
 title '\sys' with lp ls odinfs, \

# write
eval mpNext
unset ylabel
set yrange [0.9:]
set title '(b) 2M write'

plot \
'../data/ampl_data/ext4-2m-write.log' using 1:2 \
 title '\ext' with lp ls ext, \
'../data/ampl_data/pmfs-2m-write.log' using 1:2 \
 title '\pmfs' with lp ls pmfs, \
'../data/ampl_data/nova-2m-write.log' using 1:2 \
 title '\nova' with lp ls nova, \
'../data/ampl_data/winefs-2m-write.log' using 1:2 \
 title '\winefs' with lp ls winefs, \
'../data/ampl_data/odinfs-2m-write.log' using 1:2 \
 title '\sys' with lp ls odinfs, \

