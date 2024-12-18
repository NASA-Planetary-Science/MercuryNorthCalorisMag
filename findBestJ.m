function findBestJ(savename,sf,nruns,npts)

  ronly = false;
 
defval('sf',0.5:0.05:4.5);

%sf = 0.7:0.1:2;
%sf = 1.1:0.05:3;
%sf=4:0.2:7;

defval('nruns',5)
nruns
%ncore = 10; % Number of cores for parfor

% Control Variables
%Lrng = [3,130]
%Lrng=[1,130];
%Lrng=134
Lrng=150;

nsph = 1000;    % Number of triangles to fit into the region 
% Number of points randomly chose in each triangle
%npts = 15 % 5 percent subsampling, optimal based on triangle quality 
%npts = 20 % 7 percent. Try as well. This is borderline

% The three options to try:
%npts = 15 % 5 percent. The "low" option 
%npts = 24 % 8 percent. The "optimal" Same as Suisei optimum
%npts = 30 % 10 percent. The "high" option

defval('npts',86) %147%86;
npts

%npts = 24;  % 8 percent
%npts = 45; % 15 percent
%npts = 86; % 30 percent
%npts = 147; % 50 percent
%npts = 215; % 70 percent
extend = 30;
%extend = 0;
%larger = 0; % How many degrees outside to calculate rms. This dampens edge effects.
% Currently not using, rather controling energy outside

%showit=true;
showit=false;

rplanet = 2440;    % Radius of Mercury

%%% Prep Data
try
Mercury = load(['hpfdat_0.0050_alt130_Act95_EOM4077_80_HiAlt080_' ...
                  'LatMax70_Lmax25_J0.1pcnt.mat']); % See MercuryDatainfo.txt
catch
  error('Need to request bandpass filtered data')
end
  
region.type = 'NewNorthCaloris';
%NCalLon = [115,225];
%NCalLat = [48,70];
NCalLon = [105,235];
NCalLat = [48,70];


lonFull = Mercury.data2(:,6);    % Longitude
latFull = Mercury.data2(:,7);    % Latitude

% New approach for subsampling: Make larger region, random subsampling from
% larger region, then only use within nCaloris

cutind = (lonFull>= min(NCalLon)-extend & lonFull <= max(NCalLon)+extend ...
    & latFull>=min(NCalLat)-extend & latFull<=max(NCalLat)+extend ); % Region




M = Mercury.data2(cutind,:);                        % Cutting data
lon = M(:,6);    % Longitude
lat = M(:,7);    % Latitude
alt = M(:,8);    % Altitude
Br = M(:,12);    % Radial component
Bt = M(:,16);    % Colatitudinal component 
Bp = M(:,20);    % Longitudinal component
rad = alt+rplanet; % Position of MESSENGER

inside = lon>=min(NCalLon) & lon<=max(NCalLon) ...
         & lat>=min(NCalLat) & lat<=max(NCalLat);

%insideLarger =  lon>=min(NCalLon)-larger & lon<=max(NCalLon)+larger ...
%                 & lat>=min(NCalLat)-larger & lat<=max(NCalLat)+larger;

%insideSmaller = inside;

rsat = round(mean(rad(inside)));
% if showit
% scatter(lon,lat,[],Br)
% end

%keyboard

% load kernel
Ker=kernelcp(max(Lrng),region.type);
outKer = (eye(size(Ker))-Ker);

for k=1:nruns

    indx = eqAreaSubs(lon,lat,nsph,npts);  % Random subsample of data
    % Now kick out the outside points
    invindx = indx&inside;
    testindx = (~indx) & inside;
%    testindx = (~indx) & insideLarger;

    invlon = lon(invindx);  % Subsampled longitude
    invlat = lat(invindx);  % Subsampled latitude
    invrad = rad(invindx);  % Subsampled position of satellite
    invBr = Br(invindx);    % Subsampled Br
    invBt = Bt(invindx);    % Subsampled Btheta 
    invBp = Bp(invindx);    % Subsampled Bphi
    fprintf('Percentage of data used for inversion %d\n',round(sum(invindx)/sum(inside)*100)) % Percent of data used from subselection
       
    testlon = lon(testindx);  % testing longitude
    testlat = lat(testindx);  % testing latitude
    testrad = rad(testindx);  % testing position of satellite
    testBr = Br(testindx);    % testing Br
    testBt = Bt(testindx);    % testing Btheta 
    testBp = Bp(testindx);    % testing Bphi


    if showit
        scatter(invlon,invlat,[],invBr)
    end

    if ronly
      B = invBr;
    else
      B{1} = invBr; B{2} = invBt; B{3} = invBp;
    end
      
    %parfor (i=1:length(sf), ncore)
    %parfor i=1:length(sf)
    for i=1:length(sf)

      % Solve for coefficients
      %J(i) = min(round(sf(i)*spharea(region.type)*(Lmax+1)^2), (Lmax+1)^2);
      if length(Lrng)>1
        maxJ = (max(Lrng)+1)^2-(min(Lrng))^2;
      else
        maxJ = (Lrng+1)^2;
      end
      J(i) = min(round(sf(i)*spharea(region.type)*maxJ), maxJ);
      coef = LocalIntField(B, invrad, (90-invlat)*pi/180, (invlon)*pi/180, region.type, Lrng, J(i), rplanet, rsat);
      
      % Evaluate coef at retained data points
      Bcalc = rGvec(coef, (90-testlat)*pi/180, (testlon)*pi/180, testrad, rplanet, 0);
      calcBr = Bcalc(1:length(testlat))';
      calcBt = Bcalc(length(testlat)+1:2*length(testlat))';
      calcBp = Bcalc(2*length(testlat)+1:end)';

        %rG=rGvec(coefs,theta,phi,rad,rplanet,onorout)
        if showit
            subplot(2,1,1)
            scatter(testlon,testlat,[],testBr)
            colorbar

            subplot(2,1,2)
            scatter(testlon,testlat,[],calcBr)
            colorbar
        end

        errBr(k,i) = rms(testBr-calcBr);
        errBt(k,i) = rms(testBt-calcBt);
        errBp(k,i) = rms(testBp-calcBp);

        errB(k,i) = rms([errBr(k,i), errBt(k,i), errBp(k,i)]);


        % Now energy outside
        engo(k,i) = coef'*(outKer)*coef;

        engi(k,i) = coef'*Ker*coef;

        cf{k,i} = coef;

    end

end

save(fullfile('results',savename),'sf','J','errBr','errBt','errBp','errB','Lrng','nsph','npts','engo','engi', 'cf', 'region')


