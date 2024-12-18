function [spec,sig]=calcLocalSpecNewNC(coef, Ltap, N)


  %defval('region', 10); % Smaller than the actual cap for inversion
  %clat = 60;
  %clon = 215;
  %rotcoord = [clon,90-clat];
  region='NewNorthCalorisSmallerlon10lat3';
  rotcoord=[];
  rplanet=2440;

  [spec,spectap,V,sig] = localspectrum(coef2lmcosi(coef/sqrt(4*pi),0), Ltap, region, N, rotcoord,[],[],2,rplanet);
