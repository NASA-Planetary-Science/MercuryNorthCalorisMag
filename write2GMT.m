function write2GMT(wht,name,index,index2)

  rplanet = 2440;

  % larger5 and larger2 yielded the same best J for Lmax120-sub15.
  % So can just use the model for Lmax120-sub15-larger5 
  
  switch wht

    case('data')
      skip=10;
      
      Mercury = load(['hpfdat_0.0050_alt130_Act95_EOM4077_80_HiAlt080_' ...
                        'LatMax70_Lmax25_J0.1pcnt.mat']); 

      M = Mercury.data2; %(cutind,:);                        % Cutting data
      lon = M(1:skip:end,6);    % Longitude
      lat = M(1:skip:end,7);    % Latitude
      alt = M(1:skip:end,8);    % Altitude
      Br = M(1:skip:end,12);    % Radial component
      Bt = M(1:skip:end,16);    % Colatitudinal component 
      Bp = M(1:skip:end,20);    % Longitudinal component
      rad = alt+rplanet; % Position of MESSENGER

      dlmwrite(fullfile('GMTdata','locAlt.txt'),[lon, lat, alt])
      dlmwrite(fullfile('GMTdata','locBr.txt'),[lon, lat, Br])


    case('region')
      XY = NewNorthCaloris();
      dlmwrite(fullfile('GMTdata','Newregion.txt'),XY)

      XY = NewNorthCalorisSmallerlon10lat3();
      dlmwrite(fullfile('GMTdata','NewregionSmallerlo10la3.txt'),XY)
      
      %XY = NorthCaloris();
      %dlmwrite(fullfile('GMTdata','region.txt'),XY)
      
      %XY = NorthCalorisSmallerlon10lat5();
      %dlmwrite(fullfile('GMTdata','regionSmallerlo10la5.txt'),XY)

      %XY = NorthCalorisStrong();
      %dlmwrite(fullfile('GMTdata','regionStrong.txt'),XY)

      %XY = NorthCalorisSmallerlon20lat5();
      %dlmwrite(fullfile('GMTdata','regionSmallerlo20la5.txt'),XY)

    case('caloris')
      GMTmakecirc(18.2,162,90-30.5,fullfile('GMTdata','Caloris.txt'))

    case('suisei')
      GMTmakecirc(15,215,60,'GMTdata/SuiseiCap.txt')


    case('rmse')
      %defval('name','Lmax130-subs30-findBestJ-5runs-longrun');
      %defval('name','Lmax130-subs30-findBestJ-ToSf4p5-fullCollect');
      %defval('name','NewNC-Lmax134-subs30-collectAll')
      defval('name','NewNC-Lmax134-subs15-collect10')
      load(fullfile('results',name));
      foldername = fullfile('GMTdata','solutions','rms',name)
      mkdir(foldername);

      for i=1:size(errB,1)
        writematrix([J',errB(i,:)'],fullfile(foldername,sprintf('rms%d.txt',i)));
      end

      if size(errB,1)==1
        writematrix([J',errB'],fullfile(foldername,sprintf('meanrms.txt',i)));
      else
        writematrix([J',mean(errB)'],fullfile(foldername,sprintf('meanrms.txt',i)));
      end
      
    case('model')
  
      %defval('name','NewNC-Lmax134-subs30-collectAll')
      defval('name','NewNC-Lmax134-subs15-collect10')
      %index = 6;
      %index = 10;
      %index = 1%3%1; % This is for the keep coefficients
      
      load(fullfile('results',name));
      foldername = fullfile('GMTdata','solutions')

      coefs = meancoefs;
      %coefs = cf;
      
      % cf = keepcoef;
      
      
      % n = size(cf,1)
      % coefs = cf{1,index};
      % for i=2:n
      %   coefs = coefs + cf{i,index};
      % end
      % coefs = coefs/n;
         
      res = 0.2;

      GMTexportfield2(coefs{index}/sqrt(4*pi), fullfile(foldername,[name,sprintf('J%d',J(index))]), rplanet, 0, 1, [0,90,360,25],[], [], res, 0);


    case('modeldiff')

      %defval('name','NewNC-Lmax134-subs30-collectAll')
      defval('name','NewNC-Lmax134-subs15-collect10')
      %index1 = 22;
      %index2 = 10;
      %index1 = 1;
      %index2 = 3;%2;
      
      load(fullfile('results',name));
      foldername = fullfile('GMTdata','solutions')

      coefs = meancoefs;
      %coefs = cf;
      
      % cf = keepcoef;

      % n = size(cf,1);
      % coefs1 = cf{1,index1};
      % coefs2 = cf{1,index2};
      % for i=2:n
      %   coefs1 = coefs1 + cf{i,index1};
      %   coefs2 = coefs2 + cf{i,index2};
      % end
      % coefs1 = coefs1/n;
      % coefs2 = coefs2/n;
      
      res = 0.2;

      GMTexportfield2((coefs{index}-coefs{index2})/sqrt(4*pi), fullfile(foldername,[name,sprintf('J%d-%d',J(index),J(index2))]), rplanet, 0, 1, [0,90,360,25],[], [], res, 0);

      


    case('meanspec')
      %defval('index',6)  %6);
      Ltap = 6;
      Lmax = 134;
      lmin= 0;%20;
      lrng=(lmin+Ltap):(Lmax-Ltap);
      N = []% How many tapers to use?
      Wiec=true;


      defval('name','NewNC-Lmax134-subs30-collectAll')
      %defval('name','NewNC-Lmax134-subs15-collect10')

      
      defval('savename',sprintf('%s-index%d-Ltap%d-lrng%dto%d-Wiec', name, index, Ltap,min(lrng),max(lrng)))

      load(fullfile('results',name));
      foldername = fullfile('GMTdata','solutions',savename,'spec')

      mkdir(foldername)
      ls=0:Lmax;
      %region = 'NorthCalorisSmallerlon10lat5';
      region = 'NewNorthCalorisSmallerlon10lat3';

      coefs=meancoefs;
      %coefs=cf;
      
      [spec,para,fitspec,sig,chisq]=singleSourceDepth(coefs{index},Ltap,N,lrng,Lmax,Wiec);

      filename = fullfile(foldername,sprintf('meancoef-spec-depth%g-th%g-chisq%g.txt',rplanet-para(1),para(2),chisq))
      dlmwrite(filename,[ls(:), spec(:)])

      filename = fullfile(foldername,'meancoef-sigshading.txt');
      lsp = [ls(:);flipud(ls(:));ls(1)];
      spsig = [spec(:)+sig(:);flipud(spec(:)-sig(:));spec(1)+sig(1)];
      dlmwrite(filename,[lsp,spsig])

      
      filename = fullfile(foldername,'meancoef-bestFitSpec.txt');
      dlmwrite(filename,[ls(lrng+1)', fitspec(lrng+1)])
      
 
   

    case('chisq')

      % This is in the MAIN paper
      %defval('name','NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index12-Ltap6-lrng26-128-highres')
      
      % These are in the SUPPL
      %defval('name','NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index10-Ltap6-lrng26-128-highres')
      %defval('name','NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs15-10runs-index6-Ltap6-lrng26-128-highres')
      defval('name','NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs50-10runs-index6-Ltap6-lrng26-128-highres')

      % These are NOT paper or supp
      %defval('name','NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index12-Ltap11-lrng31-123-highres')
      %defval('name','NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index12-Ltap6-lrng6-128-highres')

      
      defval('savename', name)

      load(fullfile('results',name))
      
      foldername = fullfile('GMTdata','solutions',savename)
      mkdir(foldername)

      % First write out example of a chi square map
      filename = sprintf('singleChiSquare-km.grd')
      %grdwrite2p(th,rplanet-rsource,csq,fullfile(foldername,filename))
      grdwrite2p(th*pi/180*rplanet,rplanet-rsource,csq,fullfile(foldername,filename))

      % Then the min csq per depth
      [csqDepth]=singleChiSqDepthWiecz(csq);
      filename = sprintf('singleChiSquare-minPerDepth.txt')
      writematrix([csqDepth(:),rplanet-rsource(:)],fullfile(foldername,filename))


      
    case('additionalSpec')
      depth = 10
      rsource=2440 - depth;
      %index=12
      Lmax=134;
      Ltap=6;
      %lrng=(20+Ltap):(134-Ltap);
      lrng=(Ltap):(134-Ltap);
      ls = 0:Lmax;

      N=[];

      % First calculate local spectrum
      defval('name','NewNC-Lmax134-subs30-collectAll')
      %csqname = 'NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index12-Ltap6-lrng26-128-highres'
      csqname = sprintf('NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index%d-Ltap%d-lrng%d-%d-highres',index,Ltap,lrng(1),lrng(end));
      %csqname = 'NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index12-Ltap9-lrng29-125-highres'
      %csqname = 'NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs30-index10-Ltap11-lrng31-123-highres'

      
      %defval('name','NewNC-Lmax134-subs15-collect10')
      %csqname = 'NewSingleChiSqMat-NewNorthCalorisSmallerlon10lat3-Wiecz-Lmax134-subs15-10runs-index6-Ltap6-lrng26-128-highres' 
      
      defval('savename',sprintf('%s-index%d-Ltap%d-lrng%dto%d-Wiec', name, index, Ltap,min(lrng),max(lrng)))
      foldername = fullfile('GMTdata','solutions',savename,'spec')

      mod = load(fullfile('results',name));
      coef = mod.meancoefs{index};
      region = 'NewNorthCalorisSmallerlon10lat3';
      [spec,spectap,V,sig] = localspectrum(coef2lmcosi(coef/sqrt(4*pi),0), Ltap, region, N, [],[],[],2,rplanet);

      
     

      csq=load(fullfile('results',csqname));

      % find the minimum
      ind = find(csq.rsource==rsource);
      [mi,in] = min(csq.csq(ind,:));
      th = csq.th(in)
      fitspec = specWiec(rsource, th, 1, rplanet, Lmax, Ltap);
      A = bestAsig(fitspec(lrng+1),spec(lrng+1),sig(lrng+1));
      fitspec = fitspec*A;

      nparam=3;
      chisq = 1/(length(lrng+1)-nparam) *sum( ( (fitspec(lrng+1) - spec(lrng+1))./sig(lrng+1) ).^2 );

      filename = fullfile(foldername,sprintf('additional-spec-depth%g-th%g-chisq%g.txt',rplanet-rsource,th,chisq))
      dlmwrite(filename,[ls(lrng+1)', fitspec(lrng+1)])


  end


    % Write best fitting spectrum to median source depth
      %fitspec = SRD(rplanet-mean(depths),rplanet,rplanet,Lmax,Ltap);
      %mnspec = mean(cell2mat(invspecML)');
      %fitspec = bestA(fitspec(lrng+1),mnspec(lrng+1))*fitspec;
      %filename = fullfile(foldername,sprintf('fitmnspec-l%dto%d.txt',min(lrng),max(lrng)));
      %dlmwrite(filename,[lrng(:),fitspec(lrng+1)])



  
%     case('manyChisq')
%       %%%%%% This is for the many chisquare calc


% %%% Load....
%       error('need to write loading... Probably dont even want this...')

%       % Then also the count per depth of how many models allowed for the
%       % depth with one or two sigmas
%       filename = sprintf('depthProb-1sigma.txt')
%       writematrix([rplanet-rsource(:),counts1s(:)],fullfile(foldername,filename))
     
%       filename = sprintf('depthProb-2sigma.txt')
%       writematrix([rplanet-rsource(:),counts2s(:)],fullfile(foldername,filename))
      
 % case('spec')
      
 %      index = 1%10; % Keep coef index
 %      Ltap = 8;
 %      Lmax=130;
 %      %lrng=Ltap:Lmax-Ltap;
 %      lrng=26:(Lmax-Ltap);
 %      N = []% How many tapers to use?
 %      Wiec=true;
      
      
 %      %defval('name','Lmax130-subs30-findBestJ-5runs-longrun')
 %      defval('name','Lmax130-subs30-findBestJ-ToSf4p5-fullCollect')
 %      %defval('savename',sprintf('%s-Ltap%d-lrng%dto%d-Wiec', name, Ltap,min(lrng),max(lrng)))
 %      defval('savename',sprintf('%s-Ltap%d-lrng%dto%d-Wiec', name, Ltap,min(lrng),max(lrng)))
      
 %      %lrng=Ltap:Lmax-Ltap;
      
 %      load(fullfile('results',name));
 %      foldername = fullfile('GMTdata','solutions',savename,'spec')
 %      cf = keepcoef;
      
 %      mkdir(foldername)
 %      ls=0:Lmax;
 %      region = 'NorthCalorisSmallerlon10lat5';

 %      n = size(cf,1);

 %      meancoef = zeros(size(cf{1,index}));
      
 %      for i=1:n
 %        %[spec,para,fitspec,sig]=singleSourceDepthSuisei(cf{i,index},Ltap,N,lrng,Lmax,Wiec)
 %        %[spec,para,fitspec,sig]=singleSourceDepth(cf{i,index},Ltap,N,lrng,Lmax,Wiec)
 %        [spec,spectap,V,sig] = localspectrum(coef2lmcosi(cf{i,index}/sqrt(4*pi),0), Ltap, region, N, [],[],[],2,rplanet);
        
 %        filename = fullfile(foldername,sprintf('spec%d.txt',i));
 %        dlmwrite(filename,[ls(:), spec(:)])

 %        filename = fullfile(foldername,sprintf('sig%d.txt',i));
 %        dlmwrite(filename,[ls(:), sig(:)])

 %        %depths(i) = rplanet-para(1);

 %        meancoef = meancoef + cf{i,index};
 %      end

 %      meancoef = meancoef/n;
 %      [spec,para,fitspec,sig]=singleSourceDepth(meancoef,Ltap,N,lrng,Lmax,Wiec);
 %      filename = fullfile(foldername,sprintf('meancoef-spec-depth%g.txt',rplanet-para(1)));
 %      dlmwrite(filename,[ls(:), spec(:)])

 %      filename = fullfile(foldername,'meancoef-sigshading.txt');
 %      lsp = [ls(:);flipud(ls(:));ls(1)];
 %      spsig = [spec(:)+sig(:);flipud(spec(:)-sig(:));spec(1)+sig(1)];
 %      dlmwrite(filename,[lsp,spsig])

      
 %      filename = fullfile(foldername,'meancoef-bestFitSpec.txt');
 %      dlmwrite(filename,[ls(lrng+1)', fitspec(lrng+1)])
      
 %      % Also write source depths
 %      %filename = fullfile(foldername,'depths.txt');
 %      %dlmwrite(filename,[zeros(length(depths(:)),1),depths(:)])
