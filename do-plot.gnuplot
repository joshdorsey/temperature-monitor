set datafile separator ","

set xdata time
set xtics right rotate by 45
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%d/%m %H:%M"
set xrange ["$start":"$end"]

set ylabel "°C"
set y2label "°F"
set yrange [10:100]
set ytics nomirror
set y2tics
set link y2 via y*(9/5)+32 inverse (y-32)*((9/5)**(-1))

set grid x,y

set term pngcairo size 1200,600
set output '$outFile'

plot 'temperature.log' using 1:2 with lines linetype 2 linewidth 2 title "Temperature",\
     19 linetype 3 linewidth 2 title "Ambient"
