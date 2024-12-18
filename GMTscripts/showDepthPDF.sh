figname='depthProb-Lmax130-subs30-findBestJ-ToSf4p5-collectPt1and2-index10-Ltap15-lrng15-115'
loadfolder='chisq-Lmax130-subs30-findBestJ-ToSf4p5-collectPt1and2-index10-Ltap15-lrng15-115'



gmt begin ../GMTfigs/${figname}

gmt set FONT 10p



loadfile='depthProb-2sigma.txt'
gmt plot ../GMTdata/solutions/${loadfolder}/${loadfile} -JX5c/3c -R0/100/0.0/1.05 -W1p,gray -l"@[2\sigma@["

loadfile='depthProb-1sigma.txt'
gmt plot ../GMTdata/solutions/${loadfolder}/${loadfile} -Bx+l"depth [km]" -By+l"relative count" -W1p -l"@[1\sigma@["

gmt legend -DjTR+o-0.85c/0c

gmt end show
