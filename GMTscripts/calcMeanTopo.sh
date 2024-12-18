# gmt plot Newregion.txt -Am -W2p,black #or -Ap
# gmt plot NewregionSmallerlo10la3.txt -Am -W2p,black,-
# MercTopo4ppd.grd

#gmt grdmask Newregion.txt -Gmask.grd

#gmt grdmath MercTopo4ppd.grd -S  MEAN = test.txt

# Mean of the whole topo
gmt grdinfo MercTopo4ppd.grd -L2

# Mean within the modeling region
gmt grdcut  MercTopo4ppd.grd -R105/235/48/70 -GTopo4ppd-Newregion.grd
gmt grdinfo Topo4ppd-Newregion.grd -L2
# Mean is -935 m, so almost a km

# Mean within the modeling region
gmt grdcut  MercTopo4ppd.grd -R115/225/51/67 -GTopo4ppd-NewregionSmallerlo10la3.grd
gmt grdinfo Topo4ppd-NewregionSmallerlo10la3.grd -L2
# Mean is -1067m, so pretty much exactly a km below the reference radius



