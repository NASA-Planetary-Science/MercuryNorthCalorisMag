function makeExampleFunctions()

  res = 0.5; % for GMT
  
  Lmax = 150;
  ind = [570,580]%,600,1000];
  %ind1 = 1;
  %ind2 = 100;
  %ind3 = 200;

  dom = 'NewNorthCaloris';
  rplanet = 2440;
  avgsat = 2497;

  % Altitude cognizant
  [Ga,Va] = gradvecglmalphaup(dom,Lmax,avgsat,rplanet);


  % Write out eigenvalues
  filename = fullfile('GMTdata',sprintf('NorCal_L%d_eigenvalues.txt',Lmax));
  writematrix([(1:length(Va))',Va(:)],filename)


  % Write them out for GMT
  for i=1:length(ind)
    [dat,lon,lat] = plm2xyz(coef2lmcosi(Ga(:,ind(i))/sqrt(4*pi),1),res);%,region);
    filename = fullfile('GMTdata',sprintf('NorCal_L%d_ind%d.nc',Lmax,ind(i))) ;
    dat = dat/max(abs(dat(:)));
    grdwrite2p(lon,lat,dat,filename);
  end
  
