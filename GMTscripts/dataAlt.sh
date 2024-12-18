gmt begin ../GMTfigs/dataAlt pdf

gmt set MAP_POLAR_CAP None
gmt set FONT_ANNOT_PRIMARY 22p,Helvetica,black
gmt set FONT_LABEL 22p,Helvetica,black
lowlat=30


gmt grdimage ../GMTstuff/smoothplains_topo.grd  -Bxa30g30 -Bya30g15 -C../GMTstuff/sp.cpt -R0/360/${lowlat}/90 -JA0/90/14c

gmt makecpt -Clajolla -D -T0/130
gmt plot ../GMTdata/locAlt.txt -C -Sc0.08c
gmt plot ../GMTdata/Caloris.txt -W2p,80,--
gmt plot ../GMTdata/Newregion.txt -Am -W2p,black #or -Ap
#gmt plot ../GMTdata/region.txt -Am -W3p,black #or -Ap
#gmt plot ../GMTdata/SuiseiCap.txt -W2p,black

gmt colorbar -C -DJBC+w14c -Np -B20+l"altitude [km]"

gmt end show
