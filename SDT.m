function ct = SDT(c,r,param)
pFlag = 0;

k = param.k;

% Compute difference between the response to the pedestal and the response
% to the pedestal+increment
[X,Y] = meshgrid(r,r);
rMat = Y - X; clear X Y
if pFlag
    figure('windowstyle','docked')
    imagesc(rMat); hold on;
    ax = gca; ax.YDir = 'normal';
end
% Compute contour at the minimum detectable response difference
iq = contourc(rMat,[k k]);
iq(:,1) = [];
if pFlag
    plot(iq(1,:),iq(2,:),'k');
    ylabel(colorbar,'transducer response difference')
    xlabel('Pedestal Contrast')
    ylabel('Pedestal + Increment Contrast')
end
% Convert index space to contrast space
i = 1:length(c);
cq = interp1(i,c,iq);
% Convert contour to contrast increment
cqt = cq(2,:) - cq(1,:);
cq = cq(1,:);
[cq,i] = sort(cq);
cqt = cqt(i);
% Interpolate to original contrast grid
ct = interp1(cq,cqt,c);
if pFlag
    figure('windowstyle','docked')
    plot(c,ct);
end