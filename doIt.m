% Based on [Meese, T. S., et al. (2007). "Contextual modulation involves
% suppression and facilitation from the center and the surround." Journal
% of Vision 7(4): 21.]



clear all
close all


%% From Meese's fitted parameters, produce contrast response function (CRF)
% Set parameters
param.p = 3.11;
param.q = 2.59;
param.z = 32.87;
param.a = 0.323;
param.b = 0.494;

c = [exp(linspace(log(0.1),log(1),100)) exp(linspace(log(1),log(100),200))]; c = sort(unique(c));
rc = transducerFun(c,param);

fr = figure('windowstyle','docked');
plot(c,rc,'k'); hold on

%% From signal detection theory, translate CRF into a threshold vs contrast (TvC) function
param.k = 0.436;
tc = SDT(c,rc,param);

% ft = figure('windowstyle','docked');
% plot(log(c/100),log(tc/100),'k'); hold on

%% Visualize how thresholds derive from contrast response function
figure(fr)
axr = gca;
color = axr.Children.Color;

[u,maxFacil] = min(tc);
color2 = 'r';
cPedList = [0 c(maxFacil) 21.4];
for i = 1:length(cPedList)
    cPed = cPedList(i);

    if cPed==0
        rcPed = 0;
        tcPed = nan;
    else
        rcPed = interp1(c,rc,cPed);
        tcPed = interp1(c,tc,cPed);
    end
    rcPedInc = rcPed + param.k;
    cPedInc = interp1(rc,c,rcPedInc);
    
    hSlope(i) = plot([cPed cPedInc],[rcPed rcPedInc],'-','color',color2);
    if cPed==0
        x = [0 cPedInc cPedInc  0    ];
        y = [0 0       rcPedInc rcPedInc];
    else
        x = [cPed cPed cPed 0 0 cPedInc cPedInc];
        y = [0 rcPed rcPed rcPed rcPedInc rcPedInc 0];
    end
    hPatch(i) = patch(x,y,'r','FaceAlpha',0.15);
end
% set(axr.Children,'linewidth',1)
set(hSlope,'linewidth',2)
set(hPatch,'LineStyle','none');
uistack(hPatch,'bottom')
ylabel('transducer response (a.u.)')
xlabel({'pedestal contrast'})
title({'Psychophysical' 'Contrast Response Function'})

ax = gca;
ax.PlotBoxAspectRatio = [1 1 1];

xMax = cPedInc*1.1;
delta = 5;
xMax = ceil(xMax/delta)*delta;
xlim([0 xMax])
ax.XTick = 0:delta:xMax;
yMax = interp1(c,rc,xMax);
delta = 1;
yMax = ceil(yMax/delta)*delta;
ylim([0 yMax])
ax.YTick = 0:delta:yMax;

grid on
box off
f = gcf;
f.Color = 'w';


%% Visualize masking effect
param.p = 3.11;
param.q = 2.59;
param.z = 32.87;
param.a = 0.323;
param.b = 0.494;
param.k = 0.436;
c = [exp(linspace(log(0.1),log(1),100)) exp(linspace(log(1),log(100),200))]; c = sort(unique(c));
cX = [0 75];
rc = nan(length(cX),length(c));
tc = nan(length(cX),length(c));
for i = 1:length(cX)
    rc(i,:)= transducerFun(c,param,cX(i));
    tc(i,:) = SDT(c,rc(i,:),param);
end

frX = figure('windowstyle','docked');
semilogy(log(c/100),rc); hold on
hLeg = legend(cellstr([num2str(cX') repmat('%',length(cX),1)]),'location','best');
title(hLeg,'mask contrast')
ylabel({'transducer response' '(a.u.)'})
xlabel({'pedestal' '( log(contrast) )'})
xlim([log(min(c)/100) log(max(c)/100)])

ftX = figure('windowstyle','docked');
plot(log(c/100),log(tc/100))
hLeg = legend(cellstr([num2str(cX') repmat('%',length(cX),1)]),'location','best');
title(hLeg,'mask contrast')
ylabel({'contrast increment threshold' '( log(contrast) )'})
xlabel({'pedestal' '( log(contrast) )'})
xlim([log(min(c)/100) log(max(c)/100)])

return




% figure('windowstyle','docked')
% cTmp = log(c);
% plot(cTmp,resp); hold on
% plot(cTmp,resp2); hold on
% plot(cTmp,resp3); hold on

% figure('windowstyle','docked')
% cTmp = c;
% plot(cTmp,resp); hold on
% plot(cTmp,resp2); hold on
% plot(cTmp,resp3); hold on


% figure('windowstyle','docked')
% cTmp = log(c);
% plot(cTmp,log(resp)); hold on
% plot(cTmp,log(resp2)); hold on
% plot(cTmp,log(resp3)); hold on



%% Use signal detection theory to get detection thresholds
k = param.k;
[X,Y] = meshgrid(rc,rc);
rMat = Y - X; clear X Y

% figure('windowstyle','docked')
% contour(rMat,linspace(min(rMat(:)),max(rMat(:)),100));
% hold on
% contour(rMat,[k k],'k');
% figure('windowstyle','docked')
% imagesc(rMat); hold on;
% ax = gca; ax.YDir = 'normal';
% iq = contour(rMat,[k k]);
iq = contourc(rMat,[k k]);
iq(:,1) = [];

i = 1:length(c);
cq = exp(interp1(i,log(c),iq));
cqt = cq(2,:) - cq(1,:);
cq = cq(1,:);
[cq,i] = sort(cq);
cqt = cqt(i);


figure('windowstyle','docked')
ax1 = subplot(4,1,1);
plot(cq,cqt); hold on
ax1.DataAspectRatio = [1 1 1];
% yLim = ylim; yLim(1) = 0; yLim(2) = 10; ylim(yLim)
ylabel({'contrast' 'increment' 'threshold'})
xlim([0 80])
plot(xlim,cqt([1 1]),':k'); hold on
box off
ax2 = subplot(4,1,2:4);
plot(c,rc); hold on
plot(c,rX); hold on
% yLim = ylim; yLim(2) = 12; ylim(yLim)
ylabel('transducer response')
xlabel('contrast pedestal')
xlim([0 80])
box off


[a,b] = min(cqt);
cPed = cq(b);
rPed = interp1(c,rc,cPed);
rPedInc = rPed+k;
cPedInc = interp1(rc,c,rPedInc);
cqtPed = interp1(cq,cqt,cPed);

color1 = ax1.Children(end).Color;
color2 = ax2.Children(end).Color;

axes(ax2)
plot([cPed cPed],[0 rPed],':','color',color2)
plot([cPed c(end)],[rPed rPed],':','color',color2)
plot([cPedInc cPedInc],[0 rPedInc],':','color',color2)
plot([cPedInc c(end)],[rPedInc rPedInc],':','color',color2)
axes(ax1)
plot([cPed cPed],[0 cqtPed],':','color',color1)



cPed = 50;
rPed = interp1(c,rc,cPed);
rPedInc = rPed+k;
cPedInc = interp1(rc,c,rPedInc);
cqtPed = interp1(cq,cqt,cPed);

axes(ax2)
plot([cPed cPed],[0 rPed],':','color',color2)
plot([cPed c(end)],[rPed rPed],':','color',color2)
plot([cPedInc cPedInc],[0 rPedInc],':','color',color2)
plot([cPedInc c(end)],[rPedInc rPedInc],':','color',color2)
axes(ax1)
plot([cPed cPed],[0 cqtPed],':','color',color1)





% t_dbC = 20*log10(t_mC);

t_dbC = 8;
t_mC = 10.^(t_dbC./20);
log(t_mC/100)


axes(ax2)
plot([t_mC t_mC],ylim,'k')



% figure('windowstyle','docked')
% yyaxis left
% plot(cq,cqt); hold on
% yLim = ylim; yLim(1) = 0; yLim(2) = 6; ylim(yLim)
% ylabel('contrast increment threshold')
% yyaxis right
% plot(c,resp)
% yLim = ylim; yLim(2) = 12; ylim(yLim)
% ylabel('transducer response')
% xlabel('contrast pedestal')
% xlim([0 80])
% 
% 
% [a,b] = min(cqt);
% % cPed = cq(b);
% cPed = 2;
% rPed = interp1(c,resp,cPed);
% rPedInc = rPed+k;
% cPedInc = interp1(resp,c,rPedInc);
% cqtPed = interp1(cq,cqt,cPed);
% 
% yyaxis right
% plot([cPed cPed],[0 rPed],':')
% plot([cPed c(end)],[rPed rPed],':')
% plot([cPedInc cPedInc],[0 rPedInc],':')
% plot([cPedInc c(end)],[rPedInc rPedInc],':')
% yyaxis left
% % plot([cPed cPed],[0 cqtPed],':')
% 
% 
% 
% cPed = 10;
% rPed = interp1(c,resp,cPed);
% rPedInc = rPed+k;
% cPedInc = interp1(resp,c,rPedInc);
% cqtPed = interp1(cq,cqt,cPed);
% 
% yyaxis right
% plot([cPed cPed],[0 rPed],':')
% plot([cPed c(end)],[rPed rPed],':')
% plot([cPedInc cPedInc],[0 rPedInc],':')
% plot([cPedInc c(end)],[rPedInc rPedInc],':')
% yyaxis left
% % plot([cPed cPed],[0 cqtPed],':')
% 


%% Practical example
t_logC = -1.7;
mask_mC = 75;

