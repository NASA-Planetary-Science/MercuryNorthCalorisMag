
name="Lmax130-30pct"
#rmsname="Lmax130-subs30-findBestJ-5runs-longrun"
rmsname="Lmax130-subs30-findBestJ-ToSf4p5-collectPt1and2"


gmt begin ../GMTfigs/${name}-selectJ

gmt set MAP_POLAR_CAP none

gmt set FONT 12p

minval=1.8
maxval=2.35
optJ=515
optJval=2.006
placelabel=2.4
Jrng=260/2300
Jstep=400


##### Selecting J

gmt basemap -JX9c/4c -R${Jrng}/${minval}/${maxval} -Bnews 
for i in {1..40}
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
#gmt text -R0/1/0/1 -Jx9c/4c --FONT=20 <<EOF
#0.04 0.9 a
#EOF
#gmt text -R0/1/0/1 -Jx9c/4c --FONT=13 <<EOF
#0.92 0.9 30%
#EOF

# Show also other solutions
gmt plot  -Wblack <<EOF
799 ${maxval}
799 1.9394
EOF


gmt end show
