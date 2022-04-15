call "common.gnuplot" "3.3in, 1.5in"

set terminal postscript color
set output "fig3.eps"

# set multiplot layout 1,2

mp_startx=0.095
mp_starty=0.10
mp_height=0.70
mp_rowgap=0.10
mp_colgap=0.10
mp_width=.82

eval mpSetup(2, 1)

# read
eval mpNext
set ylabel 'Throughput (GiB/s)'
set yrange [0:25]
set title '(a) read'
set xtics 2 rotate by 30 offset -8,-2.5
unset key

set style data histogram
set style histogram cluster gap 1
set style fill solid border -1
set boxwidth 0.8

plot \
'../data/numa_data/read.dat' using 2:xtic(1) title 'Read thp' lc rgb C6 fillstyle pattern 3, \
'' using 3:xtic(1) title 'PM IO read' lc rgb C3 fillstyle pattern 1, \
'' using 4:xtic(1) title 'PM IO write' lc rgb C5 fillstyle pattern 2, \


# write
eval mpNext
set yrange [0:10]
unset ylabel
set title '(b) write'
set tics
set y2label "Raw PM IO (GiB/s)"

set style data histogram
set style histogram cluster gap 1
set style fill solid border -1
set boxwidth 0.8

plot \
'../data/numa_data/write.dat' using 2:xtic(1) title "Write thp" lc rgb C1 fillstyle pattern 0, \
'' using 3:xtic(1) notitle 'PM read' lc rgb C3 fillstyle pattern 1, \
'' using 4:xtic(1) notitle 'PM write' lc rgb C5 fillstyle pattern 2, \


