# ind=16
# optJ=365
# optJval=2.1331

# modnameSpec='Suisei-Lmax130-subs30-findBestJ-fullcollect-indices11-12-16-30-index16-Ltap9-lrng29to121-Wiec'
# infostr='depth35.5513-th0.429003-chisq0.869428'

# modnameField="Suisei-Lmax130-subs30-findBestJ-fullcollect-indices11-12-16-30J365_cmp1"

# loadname='Suisei-singleChiSqMat-Wiecz-Lmax130-subs30-index16-Ltap9-lrng29-121-highres'
# mincol=0.5
# onesig=1.1491
# twosig=1.2981
# minussig=0.8509
# minus2sig=0.7019
# maxchisq=1.99
# minchisq=0.55
# step=0.5
# dmin=0
# dmax=70



ind=12
optJ=307
optJval=2.15517

modnameSpec='Suisei-Lmax130-subs30-findBestJ-fullcollect-indices11-12-16-30-index12-Ltap9-lrng29to121-Wiec'
infostr='depth57.878-th0.398573-chisq0.349761'

modnameField="Suisei-Lmax130-subs30-findBestJ-fullcollect-indices11-12-16-30J307_cmp1"

loadname='Suisei-singleChiSqMat-Wiecz-Lmax130-subs30-index12-Ltap9-lrng29-121-highres'
mincol=0.25
onesig=1.1491
twosig=1.2981
minussig=0.8509
minus2sig=0.7019
maxchisq=1.5
minchisq=0.3
step=0.5
dmin=0
dmax=100







gmt begin ../GMTfigs/SuiseiAll-subs30-index${ind}

gmt set FONT 15p

yshft=-4.8c

# J selection
rmsname="Suisei-Lmax130-subs30-findBestJ-fullcollect-indices11-12-16-30"
minval=2.02
maxval=2.38
#optJ=365
#optJval=2.1331
placelabel=2.42
Jrng=146/877
Jstep=200

bmsize=10c/3c

gmt basemap -JX${bmsize} -R${Jrng}/${minval}/${maxval} -Bnews 
for i in {1..100}
do
    gmt plot ../GMTdata/solutions/rms/${rmsname}/rms${i}.txt -Wgray
done
gmt plot ../GMTdata/solutions/rms/${rmsname}/meanrms.txt -Wthick,black -Bxa$Jstep -Bya0.1 -BneSW -Bx+l"number @[J@[ of Slepian functions" -By+l"rmse [nT]"

gmt plot -Sc0.2c -Wthick <<EOF
$optJ $optJval
EOF
gmt plot -BnSeW  -Wblack <<EOF
$optJ ${maxval}
$optJ $optJval
EOF
gmt text -N  --FONT=13 <<EOF
$optJ $placelabel $optJ
EOF
# A tick mark
gmt plot -N -Sy5p <<EOF
$optJ ${maxval} 
EOF
# Label for letter
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 <<EOF
0.05 0.87 a
EOF


#### Specs
#modname='Suisei-Lmax130-subs30-findBestJ-fullcollect-indices11-12-16-30-index16-Ltap9-lrng29to121-Wiec'
#infostr='depth35.5513-th0.429003-chisq0.869428'

#modname='Suisei-Lmax130-subs30-findBestJ-fullcollect-indices11-12-16-30-index12-Ltap9-lrng29to121-Wiec'
#infostr='depth57.878-th0.398573-chisq0.349761'

shadecol=190
linecol=30
minval=5e-5
maxval=5e-2

gmt basemap -Y${yshft}  -JX${bmsize}l -R0/130/${minval}/${maxval} -BneSW -Bxa20 -By10f1p -Bx+l"spherical harmonic degree @[l@[" -By+l"power @[R_l@[ [nT@[^2@[]"
gmt plot ../GMTdata/solutions/${modnameSpec}/spec/meancoef-sigshading.txt -G${shadecol}
gmt plot ../GMTdata/solutions/${modnameSpec}/spec/meancoef-spec-${infostr}.txt -W1p,${linecol}
gmt plot ../GMTdata/solutions/${modnameSpec}/spec/meancoef-bestFitSpec.txt -W1p,${linecol},- -BneSW
# label
gmt text -JX${bmsize} --FONT=20 -R0/1/${minval}/${maxval} <<EOF
0.04 0.42e-1 c
EOF




# ChiSquared
# loadname='Suisei-singleChiSqMat-Wiecz-Lmax130-subs30-index16-Ltap9-lrng29-121-highres'
# mincol=0.5  
# onesig=1.1459
# twosig=1.2917
# minussig=0.8541
# minus2sig=0.7082
# maxchisq=1.99
# minchisq=0.55
# step=0.5
# dmin=0
# dmax=80

# loadname='Suisei-singleChiSqMat-Wiecz-Lmax130-subs30-index12-Ltap9-lrng29-121-highres'
# mincol=0.25
# onesig=1.1491
# twosig=1.2981
# minussig=0.8509
# minus2sig=0.7019
# maxchisq=1.5
# minchisq=0.3
# step=0.5
# dmin=0
# dmax=100


makecpt -Cgray -T${mincol}/${twosig}

gmt grdimage -Y${yshft} ../GMTdata/solutions/${loadname}/singleChiSquare.grd  -JX7c/-3c -R0.1/2.1/${dmin}/${dmax} -Bx+l"angular radius of sill sources [@[^\circ@[]"  -By+l"depth [km]" -Bxa0.5 -Byf10a20 -BneSW
#Bx+l"angular radius of sill sources [@[^\circ@[]" 

gmt grdcontour ../GMTdata/solutions/${loadname}/singleChiSquare.grd -C${minus2sig}, -Wfaint,white,.
gmt grdcontour ../GMTdata/solutions/${loadname}/singleChiSquare.grd -C${minussig}, -Wfaint,white,--
gmt grdcontour ../GMTdata/solutions/${loadname}/singleChiSquare.grd -C1, -Wfaint,white 
gmt grdcontour ../GMTdata/solutions/${loadname}/singleChiSquare.grd -C${onesig}, -Wfaint,white,-- 
# label
gmt text -JX7c/-3c --FONT=20 -R0/1/0/1 <<EOF
0.94 0.15 d
EOF

gmt plot -X7.5c -JX2.5c/-3c  ../GMTdata/solutions/${loadname}/singleChiSquare-minPerDepth.txt -R${minchisq}/${maxchisq}/${dmin}/${dmax} -Byf10a20 -Bxa$step -BneSw -Bx+l"@[\chi^2_\nu@[" -W1p
gmt plot -W1p,130,. <<EOF
${minus2sig} 0
${minus2sig} 100
EOF
gmt plot -W0.8p,130,- <<EOF
${minussig} 0
${minussig} 100
EOF
gmt plot -W0.8p,130 <<EOF
1 0
1 100
EOF
gmt plot -W0.8p,130,- <<EOF
${onesig} 0
${onesig} 100
EOF
gmt plot -W0.8p,130,. <<EOF
${twosig} 0
${twosig} 100
EOF
# label
gmt text -JX2.5c/-3c --FONT=20 -R0/1/0/1 <<EOF
0.85 0.15 e
EOF













#### Model
# Colorbar -30 to 30 without arrows
maxcol=30
col=../GMTstuff/colors/Merc_surface.cpt
gmt makecpt -C${col} -T-${maxcol}/${maxcol}
lowlat=30
gmt set FORMAT_FLOAT_OUT %.0f
#modname="Suisei-Lmax130-subs30-findBestJ-fullcollect-indices11-12-16-30J307_cmp1"


gmt grdimage -X3.5c -Y1.7c ../GMTdata/solutions/${modnameField}.nc  -R190/240/35/85 -JG215/60/22/10c -Bxa90g30 -Bya15g15 -E600 -BNEWS
gmt plot ../GMTstuff/SmoothPlains/SP_edit.dat -A -W0.6p,170 #-A
gmt plot ../GMTstuff/SmoothPlains/SP.dat -A -W0.6p,170
gmt plot ../GMTdata/SuiseiCap.txt -W3p,black
gmt plot ../GMTdata/SuiseiCapSpec12.txt -W3p,black,-
# label
gmt text -JX10c/10c --FONT=20 -R0/1/0/1 <<EOF
0.07 0.92 b
EOF


gmt colorbar -C -D+w10c/0.4c+h+o0c/-0.8c  -Np -L -S+x"<math>\mathbf{B}_r</math> [nT]" --FONT=19p


gmt set FORMAT_FLOAT_OUT %.1f



##### Specs







gmt end show
