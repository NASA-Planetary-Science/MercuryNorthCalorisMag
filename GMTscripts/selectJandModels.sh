subs=30
rmsname=Lmax130-subs${subs}-findBestJ-ToSf4p5-fullCollect
modprefix=Lmax130-subs${subs}-findBestJ-ToSf4p5-fullCollect-ind11-17-22
optJval=2.006
otherJval=1.9394


#subs=30
#rmsname=Lmax130-subs${subs}-findBestJ-ToSf4p5-fullCollect
#modprefix=Lmax130-subs${subs}-findBestJ-ToSf4p5-fullCollect-ind11-17-22
#optJval=2.006
#otherJval=1.9394

# subs=15
# rmsname=Lmax130-subs${subs}-findBestJ-10collect-ind11-12-14-17-22
# modprefix=Lmax130-subs${subs}-findBestJ-10collect-ind11-12-14-17-22
# optJval=2.0195
# otherJval=1.9611

# subs=50
# rmsname=Lmax130-subs${subs}-findBestJ-10collect-ind11-12-14-17-22
# modprefix=Lmax130-subs${subs}-findBestJ-10collect-ind11-12-14-17-22
# optJval=2.008
# otherJval=1.9454


gmt begin ../GMTfigs/NorthCalorisJandModels-subs${subs}

gmt set FONT 15p

# For the models
maxcol=35 


# Select J fig
minval=1.8
maxval=2.35
optJ=515
#optJval=2.006
placelabel=2.4
Jrng=260/2300
Jstep=400

bmsize=10c/5.17c


gmt basemap -JX${bmsize} -R${Jrng}/${minval}/${maxval} -Bnews 
for i in {1..10}
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
799 $placelabel 799
EOF
# A tick mark
gmt plot -N -Sy5p <<EOF
$optJ ${maxval} 
EOF
# Show also other solutions
gmt plot  -Wblack <<EOF
799 ${maxval}
799 ${otherJval}
EOF
# Label for letter
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 <<EOF
0.05 0.90 a
EOF



## Models
gmt set FORMAT_FLOAT_OUT %.0f
col=../GMTstuff/colors/Merc_surface.cpt
gmt makecpt -C${col} -T-${maxcol}/${maxcol}
lowlat=30

#### Selected model
#name=Lmax130-${subs}pct-J515

modname=${modprefix}J515_cmp1
lab=NEsw

gmt grdimage -X10.5c ../GMTdata/solutions/${modname}.nc  -R125/30/255/52.5r -JA170/59/10c -Bxa90g30 -Bya15g15 -E600 -B${lab}
gmt plot ../GMTstuff/SmoothPlains/SP_edit.dat -A -W0.6p,170 #-A
gmt plot ../GMTstuff/SmoothPlains/SP.dat -A -W0.6p,170
gmt plot ../GMTdata/Caloris.txt -W3p,80,--
gmt plot ../GMTdata/region.txt -Am -W3p,black #or -Ap
gmt plot ../GMTdata/regionSmallerlo10la5.txt -Am -W3p,black,-
# Label for letter
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 -Gwhite -C0.2c <<EOF
0.05 0.90 b
EOF



#### Other models
#name=Lmax130-${subs}pct-J799
modname=${modprefix}J799_cmp1
#modname=Lmax130-subs${subs}-findBestJ-ToSf4p5-fullCollect-ind11-17-22J799_cmp1
lab=nesW


gmt grdimage -X-10.5c -Y-7c ../GMTdata/solutions/${modname}.nc  -R125/30/255/52.5r -JA170/59/10c -Bxa90g30 -Bya15g15 -E600 -B${lab}
gmt plot ../GMTstuff/SmoothPlains/SP_edit.dat -A -W0.6p,170 #-A
gmt plot ../GMTstuff/SmoothPlains/SP.dat -A -W0.6p,170
gmt plot ../GMTdata/Caloris.txt -W3p,80,--
gmt plot ../GMTdata/region.txt -Am -W3p,black #or -Ap
gmt plot ../GMTdata/regionSmallerlo10la5.txt -Am -W3p,black,-
# Label for letter
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 -Gwhite -C0.2c <<EOF
0.05 0.90 c
EOF


#### Diff
#name=Lmax130-${subs}pct-J799-515
#modname=Lmax130-subs${subs}-findBestJ-ToSf4p5-fullCollect-ind11-17-22J515-799_cmp1
modname=${modprefix}J515-799_cmp1
lab=nEsw

gmt grdimage -X10.5c ../GMTdata/solutions/${modname}.nc  -R125/30/255/52.5r -JA170/59/10c -Bxa90g30 -Bya15g15 -E600 -B${lab}
gmt plot ../GMTstuff/SmoothPlains/SP_edit.dat -A -W0.6p,170 #-A
gmt plot ../GMTstuff/SmoothPlains/SP.dat -A -W0.6p,170
gmt plot ../GMTdata/Caloris.txt -W3p,80,--
gmt plot ../GMTdata/region.txt -Am -W3p,black #or -Ap
gmt plot ../GMTdata/regionSmallerlo10la5.txt -Am -W3p,black,-
# Label for letter
gmt text -JX${bmsize} --FONT=20 -R0/1/0/1 -Gwhite -C0.2c <<EOF
0.05 0.90 d
EOF

#### Colorbar
maxcol=35
col=../GMTstuff/colors/Merc_surface.cpt
gmt makecpt -C${col} -T-${maxcol}/${maxcol}

gmt colorbar -C -D+w15c/0.4c+e+h+o-7.75c/-0.9c -Np -L -S+x"<math>\mathbf{B}_r</math> [nT]"


gmt end show
