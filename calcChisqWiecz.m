function [csq,rsource,th,MTspec,sig]=calcChisqWiecz(coef,Ltap,lrng,N,rsource,th,reg,clon,useSpecVar) 
  % https://en.wikipedia.org/wiki/Reduced_chi-squared_statistic

  defval('reg','NewNorthCalorisSmallerlon10lat3')
  
  defval('rsource', 2340:1:2440);%linspace(2340,2440,100));
  defval('th', 0.1:0.05:2.1);%linspace(0.1,2.1,20));%linspace(0.01,2.5,50));
  defval('useSpecVar',false)
  %defval('A',linspace(1e-8,1e-5,250));
%          logspace(1e-8,1e-2,50)); % Logspace is bad... 
  %rsource = [2000,2440];
  %A = 3.9558e-06;

  ls = min(lrng):max(lrng);

  Lmax = sqrt(length(coef))-1
  %Ltap = 15;
  %N = 10;
  %N=[];
  rplanet = 2440;
  if isstr(reg)
    %if strcmp(reg,'NorthCaloris')
    %region = 'NorthCalorisStrong';
    %region =  'NorthCalorisSmallerlon10lat5';
    %region =  'NorthCalorisSmallerlon5lat2';
    %region =  'NorthCalorisSmallerlon20lat5';
    region = reg
    rotcoord = [];
  else
    % Could also make this an 
    region = reg%10; % Full would be 15
    clat = 60;
    %clon = 215;
    rotcoord = [clon,90-clat];
  end

  if useSpecVar
    [MTspec,spectap,V,sig,specvar] = localspectrum(coef2lmcosi(coef/sqrt(4*pi),0), Ltap, region, N, rotcoord,[],[],2,rplanet);
    sig=specvar; % We're using specvar instead of sig as uncertainty
  else
    [MTspec,spectap,V,sig] = localspectrum(coef2lmcosi(coef/sqrt(4*pi),0), Ltap, region, N, rotcoord,[],[],2,rplanet);
  end
    
  %SV = cell2mat(spectap);
  %sig = std(SV,V(1:N),2);
  nparam = 3;
  %csq = nan(length(rsource),length(th),length(A));
  csq = nan(length(rsource),length(th));
  M = mcouplings(Ltap,Lmax,0);
  for i=1:length(rsource)
    %srdspec = SRD(rsource(i),rplanet,rplanet,Lmax,Ltap,M);
    fprintf('   ... %d out of %d done\n',i,length(rsource))
    parfor j=1:length(th)
      wiecspec = specWiec(rsource(i),th(j),1,rplanet,Lmax,Ltap,M);
      %for k=1:length(A)
      A = bestAsig(wiecspec(ls+1),MTspec(ls+1),sig(ls+1));
      csq(i,j) = chisqSpecMisf(A*wiecspec,MTspec,sig,nparam,lrng);
     %end
    end
  end


  % 1+sqrt(2/(length(lrng)-nparam));
  % 1+2*sqrt(2/(length(lrng)-nparam));
  

%try
%  save('test.mat','csq','rsource','A','th')
%catch
%  keyboard
%end
