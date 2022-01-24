% Based on [Meese, T. S., et al. (2007). "Contextual modulation involves
% suppression and facilitation from the center and the surround." Journal
% of Vision 7(4): 21.]


clear all
close all


p = 3.11;
q = 2.59;
% z = 32.87;
z = 5;

a = 0.323;
b = 0.494;

c = [exp(linspace(log(0.1),log(1),100)) exp(linspace(log(1),log(15),60))];
% c = [exp(linspace(log(0.01),log(0.1),100)) exp(linspace(log(0.1),log(1),100)) exp(linspace(log(1),log(100),100))];
c = sort(unique(c));

cx = 0;
resp = (c.^p).*(1+a.*cx) ./ ( z + (c.^q).*(1+b.*cx) );
cx = 10;
resp2 = (c.^p).*(1+a.*cx) ./ ( z + (c.^q).*(1+b.*cx) );
cx = 100;
resp3 = (c.^p).*(1+a.*cx) ./ ( z + (c.^q).*(1+b.*cx) );

% figure('windowstyle','docked')
% cTmp = log(c);
% plot(cTmp,resp); hold on
% plot(cTmp,resp2); hold on
% plot(cTmp,resp3); hold on

figure('windowstyle','docked')
cTmp = c;
plot(cTmp,resp); hold on
% plot(cTmp,resp2); hold on
% plot(cTmp,resp3); hold on


% figure('windowstyle','docked')
% cTmp = log(c);
% plot(cTmp,log(resp)); hold on
% plot(cTmp,log(resp2)); hold on
% plot(cTmp,log(resp3)); hold on



%% Use signal detection theory to get detection thresholds
k = 0.436;
[X,Y] = meshgrid(resp,resp);
respMat = Y - X; clear X Y

% figure('windowstyle','docked')
% contour(respMat,linspace(min(respMat(:)),max(respMat(:)),100));
% hold on
% contour(respMat,[k k],'k');
% figure('windowstyle','docked')
% imagesc(respMat); hold on;
% ax = gca; ax.YDir = 'normal';
% iq = contour(respMat,[k k]);
iq = contourc(respMat,[k k]);
iq(:,1) = [];

i = 1:length(c);
cq = exp(interp1(i,log(c),iq));
cqt = cq(2,:) - cq(1,:);
cq = cq(1,:);


figure('windowstyle','docked')
yyaxis left
plot(cq,cqt); hold on
yLim = ylim; yLim(1) = 0; ylim(yLim)
ylabel('contrast increment threshold')
yyaxis right
plot(c,resp)
yLim = ylim; yLim(2) = 5; ylim(yLim)
ylabel('transducer response')
xlabel('contrast pedestal')


[a,b] = min(cqt);
cPed = cq(b);
rPed = interp1(c,resp,cPed);
rPedInc = rPed+k;
cPedInc = interp1(resp,c,rPedInc);
cqtPed = interp1(cq,cqt,cPed);

yyaxis right
plot([cPed cPed],[0 rPed],':')
plot([cPed c(end)],[rPed rPed],':')
plot([cPedInc cPedInc],[0 rPedInc],':')
plot([cPedInc c(end)],[rPedInc rPedInc],':')
yyaxis left
plot([cPed cPed],[0 cqtPed],':')



cPed = 10;
rPed = interp1(c,resp,cPed);
rPedInc = rPed+k;
cPedInc = interp1(resp,c,rPedInc);
cqtPed = interp1(cq,cqt,cPed);

yyaxis right
plot([cPed cPed],[0 rPed],':')
plot([cPed c(end)],[rPed rPed],':')
plot([cPedInc cPedInc],[0 rPedInc],':')
plot([cPedInc c(end)],[rPedInc rPedInc],':')
yyaxis left
plot([cPed cPed],[0 cqtPed],':')

