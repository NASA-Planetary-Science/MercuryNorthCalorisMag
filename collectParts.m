function collectParts(loadnames,keepind,savename)

 % warning("I'm not entirely sure if I did the mean coefficients right...")

  errB = [];
  errBr= [];
  errBt= [];
  errBp= [];

  nparts = length(loadnames)
  
  pt = load(sprintf('./results/largeFiles/%s.mat',loadnames{1}));
  for j=1:length(pt.sf)
    meancoefs{j} = zeros(size(pt.cf{1,1}));
  end

  totalcount = 0;
  for i=1:nparts

    pt = load(sprintf('./results/largeFiles/%s.mat',loadnames{i}));

    errB = [errB;pt.errB];
    errBr = [errBr;pt.errBr];
    errBt = [errBt;pt.errBt];
    errBp = [errBp;pt.errBp];
    
    for j=1:size(pt.cf,2)
      thiscf = pt.cf{1,j};
      partmeancoefs{j}=zeros(size(thiscf));
      for k=2:size(pt.cf,1)
          thiscf = thiscf + pt.cf{k,j};
      end

      partmeancoefs{j} = partmeancoefs{j} + thiscf/size(pt.cf,1);

    end

    for j=1:length(pt.sf)
      meancoefs{j} = meancoefs{j} + partmeancoefs{j};
    end

    
    for k=1:size(pt.cf,1) 
      totalcount = totalcount +1;
      for j=1:length(keepind)
        keepcoef{totalcount,j} = pt.cf{k,keepind(j)};
      end
    end
    
  end


   for j=1:length(pt.sf)
      meancoefs{j} = meancoefs{j}/nparts;
   end

  %what I'ved done so far is calculate meancoefs for each part. 
  
  %for j=1:size(pt.cf,2)
  %  meancoefs{j}=meancoefs{j}/nparts;
  %end
  
  sf = pt.sf;
  J = pt.J;
  %region = pt.region;



  save(sprintf('./results/%s.mat',savename),'sf','J','errB','errBt','errBp','errBr','meancoefs','keepcoef','keepind')
