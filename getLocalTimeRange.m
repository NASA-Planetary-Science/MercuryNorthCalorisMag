function [MSOlon,abbMSOlon,alt,orbit]=getLocalTimeRange()

  Mercury = load(['hpfdat_0.0050_alt130_Act95_EOM4077_80_HiAlt080_' ...
                  'LatMax70_Lmax25_J0.1pcnt.mat']); % See MercuryDatainfo.txt

  NCalLon = [115,225];
  NCalLat = [48,70];
  extend = 0;

  lonFull = Mercury.data2(:,6);    % Longitude
  latFull = Mercury.data2(:,7);    % Latitude

  cutind = (lonFull>= min(NCalLon)-extend & lonFull <= max(NCalLon)+extend ...
            & latFull>=min(NCalLat)-extend & latFull<=max(NCalLat)+extend ); % Region

  M = Mercury.data2(cutind,:);     

  
  MSOlon = M(:,31);
  abbMSOlon = M(:,32);
  alt = M(:,8);
  orbit = M(:,33);
  
  %min(MSOlon)
  %max(MSOlon)
  %min(abbMSOlon)
  %max(abbMSOlon)
