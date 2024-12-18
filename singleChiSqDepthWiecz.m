function [csqDepth,counts]=singleChiSqDepthWiecz(csq,csqThresh)
  % New: Only 2D, no more amplitude
  
  csqDepth = min(csq');
  %csqDepth = nan(size(csq,1),1);
  %for i=1:length(csqDepth)
  %  csqDepth(i) = min(reshape(csq(i,:,:),numel(csq(i,:,:)),1));
  %end
  
  defval('csqThresh',[])

  if csqThresh
    counts = csqDepth<=csqThresh;
  else
    counts = [];
  end
