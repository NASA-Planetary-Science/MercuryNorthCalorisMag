gmt begin ../GMTfigs/dataBr pdf

gmt set MAP_POLAR_CAP None
gmt set FONT_ANNOT_PRIMARY 22p,Helvetica,black
gmt set FONT_LABEL 22p,Helvetica,black
gmt set FORMAT_FLOAT_MAP %3.0f
lowlat=30



gmt grdimage ../GMTstuff/smoothplains_topo.grd  -Bxa30g30 -Bya30g15 -C../GMTstuff/sp.cpt -R0/360/${lowlat}/90 -JA0/90/14c

col=../GMTstuff/colors/Merc_surface.cpt
gmt makecpt -C${col} -T-20/20 
#gmt makecpt -Clajolla -D -T0/130
gmt plot ../GMTdata/locBr.txt -C -Sc0.08c
gmt plot ../GMTdata/Caloris.txt -W2p,80,--
gmt plot ../GMTdata/Newregion.txt -Am -W2p,black #or -Ap
#gmt plot ../GMTdata/NewregionSmallerlo10la3.txt -Am -W2p,black,-- #or -Ap
#gmt plot ../GMTdata/SuiseiCap.txt -W2p,black

#gmt colorbar -C -DJBC+w14c+e -Np -L -S+x"@[\bm{B}_r@[ [nT]"

gmt colorbar -C -DJBC+w14c+e -Np -L -S+x"<math>\mathbf{B}_r</math> [nT]"

gmt end show
