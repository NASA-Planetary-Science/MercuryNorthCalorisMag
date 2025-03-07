# 1 is subs30, index12, Ltap6. The one in the main text
# 2 is subs30, index10, Ltap6. In suppl
# 3 is subs15, index6, Ltap6. In suppl
# 4 is subs50, index6, Ltap6. In suppl 

wch=1

if [[ $wch -eq 2 ]]; then
    modname=NewNC-Lmax134-subs30-collectAll-index10-Ltap6-lrng26to128-Wiec
    infostr=depth54.4107-th0.392303-chisq0.43824
    add1=additional-spec-depth10-th1.47-chisq0.944328
    add2=additional-spec-depth30-th1.23-chisq0.626784
    depthlabel=54.4
    
elif [[ $wch -eq 1 ]]; then
    modname=NewNC-Lmax134-subs30-collectAll-index12-Ltap6-lrng26to128-Wiec
    infostr=depth53.8551-th0.405163-chisq0.492439
    add1=additional-spec-depth10-th1.47-chisq1.01078 
    add2=additional-spec-depth30-th1.23-chisq0.688225
    depthlabel=53.9

elif [[ $wch -eq 3 ]]; then    
    modname=NewNC-Lmax134-subs15-collect10-index6-Ltap6-lrng26to128-Wiec
    infostr=depth54.3084-th0.399852-chisq0.483338
    add1=additional-spec-depth10-th1.49-chisq0.99438
    add2=additional-spec-depth30-th1.23-chisq0.677965
    depthlabel=54.3

elif [[ $wch -eq 4 ]]; then
    modname=NewNC-Lmax134-subs50-collect10-index6-Ltap6-lrng26to128-Wiec
    infostr=depth53.6744-th0.460039-chisq0.470142
    add1=additional-spec-depth10-th1.49-chisq0.97238
    add2=additional-spec-depth30-th1.25-chisq0.657614
    depthlabel=53.7
fi

### From here on: Not in paper nor suppl

# modname=NewNC-Lmax134-subs30-collectAll-index12-Ltap9-lrng29to125-Wiec
# infostr=depth61.0155-th0.405857-chisq0.418002
# add1=additional-spec-depth10-th1.53-chisq0.926771
# add2=additional-spec-depth30-th1.31-chisq0.658459
# depthlabel=61.0

# modname=NewNC-Lmax134-subs30-collectAll-index12-Ltap11-lrng31to123-Wiec
# infostr=depth60.4567-th0.571303-chisq0.405095
# add1=additional-spec-depth10-th1.55-chisq0.880977
# add2=additional-spec-depth30-th1.33-chisq0.632216
# depthlabel=60.5

# modname=NewNC-Lmax134-subs30-collectAll-index10-Ltap9-lrng29to125-Wiec
# infostr=depth61.1314-th0.459873-chisq0.367338
# add1=additional-spec-depth10-th1.57-chisq0.852111
# add2=additional-spec-depth30-th1.35-chisq0.59554
# depthlabel=61.1

# modname=NewNC-Lmax134-subs30-collectAll-index10-Ltap11-lrng31to123-Wiec
# infostr=depth63.6358-th0.436479-chisq0.34183 
# add1=additional-spec-depth10-th1.59-chisq0.802938
# add2=additional-spec-depth30-th1.37-chisq0.568096
# depthlabel=63.6

# modname=NewNC-Lmax134-subs30-collectAll-index12-Ltap6-lrng6to128-Wiec
# infostr=depth27.8364-th1.05874-chisq0.794574 
# add1=additional-spec-depth10-th1.5-chisq0.937978
# add2=additional-spec-depth30-th1-chisq0.797554
# depthlabel=27.8


if [[ $wch -eq 2 ]]; then
    gmt begin ../GMTfigs/NewNorthCalorisMeanSpecChiSq-Lmax134-subs30-index10-Poster
elif [[ $wch -eq 1 ]]; then
    gmt begin ../GMTfigs/NewNorthCalorisMeanSpecChiSq-Lmax134-subs30-index12-Poster
elif [[ $wch -eq 3 ]]; then
    gmt begin ../GMTfigs/NewNorthCalorisMeanSpecChiSq-Lmax134-subs15-index6-Poster
elif [[ $wch -eq 4 ]]; then
    gmt begin ../GMTfigs/NewNorthCalorisMeanSpecChiSq-Lmax134-subs50-index6-Poster
fi
    
#### From here on not in paper nor suppl
#gmt begin ../GMTfigs/NewNorthCalorisMeanSpecChiSq-Lmax134-subs30-index12-Ltap9
#gmt begin ../GMTfigs/NewNorthCalorisMeanSpecChiSq-Lmax1-subs30-index12-Ltap11
#gmt begin ../GMTfigs/NewNorthCalorisMeanSpecChiSq-Lmax134-subs30-index10-Ltap9
#gmt begin ../GMTfigs/NewNorthCalorisMeanSpecChiSq-Lmax134-subs30-index10-Ltap11
#gmt begin ../GMTfigs/NewNorthCalorisMeanSpecChiSq-Lmax134-subs30-index12-Ltap6-lrng6to128

gmt set FONT 13p

height=4c

# Spec

shadecol=190
linecol=30
lcoladd=0.7p,100
minval=1e-4
maxval=1e-1

gmt basemap  -JX8.5c/${height}l -R0/134/${minval}/${maxval} -BneSW -Bxa20 -By10f1p -Bx+l"spherical harmonic degree @[l@[" -By+l"power @[R_l@[ [nT@[^2@[]"
gmt plot ../GMTdata/solutions/${modname}/spec/meancoef-sigshading.txt -G${shadecol}
gmt plot ../GMTdata/solutions/${modname}/spec/meancoef-spec-${infostr}.txt -W1p,${linecol}
gmt plot ../GMTdata/solutions/${modname}/spec/meancoef-bestFitSpec.txt -W1p,${linecol},- -BneSW -l"${depthlabel} km"
gmt plot ../GMTdata/solutions/${modname}/spec/${add2}.txt -W${lcoladd},.- -l"30 km"
gmt plot ../GMTdata/solutions/${modname}/spec/${add1}.txt -W${lcoladd},. -l"10 km"

gmt legend -DjBR

# label
gmt text -JX${bmsize} --FONT=20 -R0/1/${minval}/${maxval} <<EOF
0.04 0.45e-1 a
EOF



# ChiSquared

####### For main and suppl
### For Ltap = 6
mincol=-0.1
twosig=1.2828
onesig=1.1414
minussig=0.8586
minus2sig=0.7172
maxcol=${onesig}


########### These are neither in main nor in suppl
### For Ltap = 9
# mincol=0.3
# twosig=1.2917
# onesig=1.1459
# minussig=0.8541
# minus2sig=0.7083

### For Ltap = 11
# mincol=0.3
# twosig=1.2981
# onesig=1.1491
# minussig=0.8509
# minus2sig=0.7019

### For Ltap = 6, lrng = 6 to 128
# mincol=0.65   
# twosig=1.2593
# onesig=1.1296
# minussig=0.8704
# minus2sig=0.7407




if [[ $wch -eq 2 ]]; then
    loadname=NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index10-Ltap6-lrng26-128-highres
    optDepth=54.4107
    #optTh=0.392303
    optTh=17
    maxchisq=1.3
    minchisq=0.4

elif [[ $wch -eq 1 ]]; then
    loadname=NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index12-Ltap6-lrng26-128-highres
    optDepth=53.8551
    #optTh=0.405163
    optTh=17.5
    maxchisq=1.3
    minchisq=0.45

elif [[ $wch -eq 3 ]]; then
    loadname=NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs15-10runs-index6-Ltap6-lrng26-128-highres
    optDepth=54.3084
    #optTh=0.399852
    optTh=17
    maxchisq=1.3
    minchisq=0.4

elif [[ $wch -eq 4 ]]; then    
    loadname=NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs50-10runs-index6-Ltap6-lrng26-128-highres
    optDepth=53.6744
    #optTh=0.460039
    optTh=20
    maxchisq=1.3
    minchisq=0.4
fi

#### From here on neither in paper not in suppl

# loadname=NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index12-Ltap9-lrng29-125-highres
# optDepth=61.0155
# optTh=0.405857
# maxchisq=1.5
# minchisq=0.3

# loadname=NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index12-Ltap11-lrng31-123-highres
# optDepth=60.4567
# optTh=0.571303
# maxchisq=1.2
# minchisq=0.3

# loadname=NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index10-Ltap9-lrng29-125-highres
# optDepth=61.1314
# optTh=0.459873
# maxchisq=1.2
# minchisq=0.3

# loadname=NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index10-Ltap11-lrng31-123-highres
# optDepth=63.6358
# optTh=0.436479
# maxchisq=1.2
# minchisq=0.3

# loadname=NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index12-Ltap6-lrng6-128-highres
# optDepth=27.8364
# optTh=1.05874
# maxchisq=1.5
# minchisq=0.66

dmin=0
dmax=80

labshift=1.093
lab=$(bc <<< "${dmax}*${labshift}")

shift=0.06
minussigshift=$(bc <<< "${minussig}-${shift}")
onesigshift=$(bc <<< "${onesig}+${shift}")

cat << EOF >| annots.txt
${minussig} f 1-@~s@~		      
1 f 1	    
${onesig} f 1+@~s@~
EOF


# cat << EOF >| annots.txt
# ${minus2sig} a 1-2@~s@~		      
# 1 a 1	    
# ${twosig} a 1+2@~s@~
# EOF

# cat << EOF >| annots.txt
# ${minus2sig} ag @~1-2s@~
# ${minussig} g		      
# 1 ag 1
# ${onesig} g 	    
# ${twosig} ag @~1+2s@~
# EOF

makecpt -Cgray -T${mincol}/${maxcol}

# -Bx+l"angular radius of sill sources [@[^\circ@[]"
# -Bx+l"radius of disk-shaped sources [@[^\circ@[]" -Bxa0.5
# -R0.1/2.1/${dmin}/${dmax}
gmt basemap -Y-6c  -JX5c/-${height} -R2.2/78/${dmin}/${dmax} -Bx+l"horizontal correlation scale [km]"  -By+l"depth [km]" -Bxf10a20 -Byf10a20 -BneSW
grdimage ../GMTdata/solutions/${loadname}/singleChiSquare-km.grd

#gmt grdcontour ../GMTdata/solutions/${loadname}/singleChiSquare-km.grd -C${minus2sig}, -W0.5p,black,-
gmt grdcontour ../GMTdata/solutions/${loadname}/singleChiSquare-km.grd -C${minussig}, -W0.8p,black,-
gmt grdcontour ../GMTdata/solutions/${loadname}/singleChiSquare-km.grd -C1, -W1.2p,black 
gmt grdcontour ../GMTdata/solutions/${loadname}/singleChiSquare-km.grd -C${onesig}, -W0.8p,black,-
#gmt grdcontour ../GMTdata/solutions/${loadname}/singleChiSquare-km.grd -C${twosig}, -W0.5p,black,-
gmt plot -Sc0.2c -W0.6p,black <<EOF
${optTh} ${optDepth}
EOF
# label
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 <<EOF
0.06 0.1 b
EOF


#cl=130
cl=100
#glcol=0.5p,${cl}
glcol=0.8p,black

# gmt plot -X6c -JX3c/-${height}  ../GMTdata/solutions/${loadname}/singleChiSquare-minPerDepth.txt -R${minchisq}/${maxchisq}/${dmin}/${dmax} -Byf10a20 -Bpxcannots.txt -BneSw  -W1p -Bx+l"min @[\chi^2_\nu@[" --MAP_GRID_PEN=faint,100
gmt plot -X5.5c -JX3c/-${height}  ../GMTdata/solutions/${loadname}/singleChiSquare-minPerDepth.txt -R${minchisq}/${maxchisq}/${dmin}/${dmax} -Byf10a20 -Bxcannots.txt -BneSw -W1p,${cl} #--MAP_TICK_LENGTH_PRIMARY=6.6p


axlabshift=1.14
axlab=$(bc <<< "${lab}*${axlabshift}")
gmt text -N <<EOF
${minussigshift} ${lab} 1-@~s@~		      
1 ${lab} 1	    
${onesigshift} ${lab} 1+@~s@~
1 ${axlab} min @[\chi^2_\nu@[
EOF




# gmt plot -W${glcol},- <<EOF
# ${minus2sig} 0
# ${minus2sig} 100
# EOF
gmt plot -W${glcol},- <<EOF
${minussig} 0
${minussig} 100
EOF
gmt plot -W1.2p,black <<EOF
1 0
1 100
EOF
gmt plot -W${glcol},- <<EOF
${onesig} 0
${onesig} 100
EOF
# gmt plot -W${glcol},- <<EOF
# ${twosig} 0
# ${twosig} 100
# EOF


# label
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 <<EOF
0.15 0.12 c
EOF
#0.85 0.12 c


gmt end show
