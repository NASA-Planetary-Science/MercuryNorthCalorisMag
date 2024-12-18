function [spec,para,fitspec,sig,chisq]=singleSourceDepth(coef,Ltap,N,lrng,Lmax,Wiec,useSpecVar)

  defval('useSpecVar',false)
  defval('Wiec',false)
  defval('N',(Ltap+1)^2)
  rplanet = 2440;
  %warning('shifted rplanet for test')
  %rplanet = 2440+60;
  startsill = 1;

  %region = 'NorthCaloris';
  %region =  'NorthCalorisSmallerlon5lat2';
  region =  'NewNorthCalorisSmallerlon10lat3';

  %Lmax=130;

  if useSpecVar
    [spec,spectap,V,sig,specvar] = localspectrum(coef2lmcosi(coef/sqrt(4*pi),0), Ltap, region, N, [],[],[],2,rplanet);
    sig=specvar; %We're using specvar instead of sig as uncertainty
  else
    [spec,spectap,V,sig] = localspectrum(coef2lmcosi(coef/sqrt(4*pi),0), Ltap, region, N, [],[],[],2,rplanet);  
  end
  
  %SV = cell2mat(spectap).*V(1:N)';
  %SV = cell2mat(spectap);
  %sig = std(SV,[],2);
  %sig = std(SV,V(1:N)'/sum(V(1:N)),2);
  %sig = std(SV,V(1:N),2);
 

  if Wiec
    optA=true%false%true;
    parastart = [rplanet,startsill];
    [para,chisq] = findParaMinDiff_Wiec(spec,lrng,rplanet,parastart,Ltap,Lmax,sig,optA);
    %optA=false;
    %parastart = [rplanet-40,rplanet-60,startsill];
    %[para,chisq] = findParaMinDiff_WiecTB(spec,lrng,rplanet,parastart,Ltap,Lmax,sig,optA);
    
    depth = rplanet-para(1)
    fitspec =specWiec(para(1),para(2),1,rplanet,Lmax,Ltap);
    if optA
      A = para(3);
    else
      A = bestAsig(fitspec(lrng+1),spec(lrng+1),sig(lrng+1));
    end


  else
    rstart = rplanet;
    [rsource,A,chisq] = findDepthMinDiff_SRD(spec,lrng,rplanet,rplanet,rstart,Ltap,Lmax,sig);

    depth=rplanet-rsource
    para = [rsource,A];
    fitspec = SRD(rsource,rplanet,rplanet,Lmax,Ltap);
  %  rsource = findDepthMinDiff_SRD(spec,lrng,rplanet,rplanet,rstart,Ltap,Lmax);

  end


  fitspec=A*fitspec;
