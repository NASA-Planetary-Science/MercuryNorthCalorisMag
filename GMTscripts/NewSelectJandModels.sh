rmsname=NewNC-Lmax134-subs30-collectAll
optJ=679   #614
optJval=1.9551    #1.9720
#optJ=614   #679   #614
#optJval=1.9720   #1.9551    #1.9720
otherJ=938
otherJval=1.9134
Jrng=323/2500
Jstep=500
modprefix=${rmsname}
figname=NewNorthCalorisJandModels-Lmax134-subs30-index12  # This one for 679
#figname=NewNorthCalorisJandModels-Lmax134-subs30-index10  # This one for 614

# Don/t know what this is....
#otherJ=1157
#otherJval=1.89094


# rmsname=NewNC-Lmax134-subs50-collect10
# optJ=647   #679   #614
# optJval=1.9660   #1.9551    #1.9720
# otherJ=905
# otherJval=1.9243
# Jrng=323/2500
# Jstep=500
# modprefix=${rmsname}
# figname=NewNorthCalorisJandModels-Lmax134-subs50-index6

# rmsname=NewNC-Lmax134-subs15-collect10
# optJ=647   #679   #614
# optJval=1.9742   #1.9551    #1.9720
# otherJ=905
# otherJval=1.9307
# Jrng=323/2500
# Jstep=500
# modprefix=${rmsname}
# figname=NewNorthCalorisJandModels-Lmax134-subs15-index6


gmt begin ../GMTfigs/${figname}   #-index12

gmt set FONT 15p

# For the models
maxcol=44 


# Select J fig
minval=1.8
maxval=2.35
#optJval=2.006
placelabel=2.39


#bmsize=10c/5.17c
bmsize=10c/4.69c


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
${optJ} ${placelabel} ${optJ}
${otherJ} ${placelabel} ${otherJ}
EOF
# A tick mark
gmt plot -N -Sy5p <<EOF
$optJ ${maxval} 
EOF
gmt plot -N -Sy5p <<EOF
$otherJ ${maxval} 
EOF
# Show also other solutions
gmt plot  -Wblack <<EOF
${otherJ} ${maxval}
${otherJ} ${otherJval}
EOF
# Label for letter
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 <<EOF
0.05 0.88 a
EOF



## Models
lolaOld=125/30/255/52.5r 
lola=120/27/260/47.5r

gmt set FORMAT_FLOAT_OUT %.0f
col=../GMTstuff/colors/Merc_surface.cpt
gmt makecpt -C${col} -T-${maxcol}/${maxcol}
lowlat=30

#### Selected model
#name=Lmax130-${subs}pct-J515

modname=${modprefix}J${optJ}_cmp1
lab=NEsw

gmt grdimage -X10.5c ../GMTdata/solutions/${modname}.nc  -R${lola} -JA170/59/10c -Bxa90g30 -Bya15g15 -E600 -B${lab}
#gmt plot ../GMTstuff/SmoothPlains/SP_edit.dat -A -W0.6p,170 #-A
#gmt plot ../GMTstuff/SmoothPlains/SP.dat -A -W0.6p,170
gmt plot ../GMTdata/Caloris.txt -W2p,80,--
gmt plot ../GMTdata/Newregion.txt -Am -W2p,black #or -Ap
gmt plot ../GMTdata/NewregionSmallerlo10la3.txt -Am -W2p,black,-
# Label for letter
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 -Gwhite -C0.2c <<EOF
0.05 0.88 b
EOF



#### Other models
#name=Lmax130-${subs}pct-J799
modname=${modprefix}J${otherJ}_cmp1
#modname=Lmax130-subs${subs}-findBestJ-ToSf4p5-fullCollect-ind11-17-22J799_cmp1
lab=nesW


gmt grdimage -X-10.5c -Y-6.5c ../GMTdata/solutions/${modname}.nc  -R${lola}  -JA170/59/10c -Bxa90g30 -Bya15g15 -E600 -B${lab}
#gmt plot ../GMTstuff/SmoothPlains/SP_edit.dat -A -W0.6p,170 #-A
#gmt plot ../GMTstuff/SmoothPlains/SP.dat -A -W0.6p,170
gmt plot ../GMTdata/Caloris.txt -W2p,80,--
gmt plot ../GMTdata/Newregion.txt -Am -W2p,black #or -Ap
gmt plot ../GMTdata/NewregionSmallerlo10la3.txt -Am -W2p,black,-
# Label for letter
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 -Gwhite -C0.2c <<EOF
0.05 0.88 c
EOF


#### Diff
#name=Lmax130-${subs}pct-J799-515
#modname=Lmax130-subs${subs}-findBestJ-ToSf4p5-fullCollect-ind11-17-22J515-799_cmp1
modname=${modprefix}J${optJ}-${otherJ}_cmp1
lab=nEsw

gmt grdimage -X10.5c ../GMTdata/solutions/${modname}.nc  -R${lola} -JA170/59/10c -Bxa90g30 -Bya15g15 -E600 -B${lab}
#gmt plot ../GMTstuff/SmoothPlains/SP_edit.dat -A -W0.6p,170 #-A
#gmt plot ../GMTstuff/SmoothPlains/SP.dat -A -W0.6p,170
gmt plot ../GMTdata/Caloris.txt -W2p,80,--
gmt plot ../GMTdata/Newregion.txt -Am -W2p,black #or -Ap
gmt plot ../GMTdata/NewregionSmallerlo10la3.txt -Am -W2p,black,-
# Label for letter
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 -Gwhite -C0.2c <<EOF
0.05 0.88 d
EOF

#### Colorbar

col=../GMTstuff/colors/Merc_surface.cpt
gmt makecpt -C${col} -T-${maxcol}/${maxcol}

gmt colorbar -C -D+w15c/0.4c+e+h+o-7.75c/-0.9c -Np -L -S+x"<math>\mathbf{B}_r</math> [nT]"


gmt end show
