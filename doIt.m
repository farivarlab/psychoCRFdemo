% Illustration of how signal detection theory allows to extract a
% psychophysical contrast response function (CRF) from the threshold vs
% contrast (TvC) function. It additionally shows how a constant cross
% oriented mask affects the CRF.
%
% By Sébastien Proulx, sebastien.proul2@mail.mcgill.ca, https://orcid.org/0000-0003-1709-3277 
% License: CC-BY 4.0 (https://creativecommons.org/licenses/by/4.0/)
% Published on GitHub (https://github.com/farivarlab/psychoCRFdemo)
%
% Based on data, models and fits from [Meese, T. S., et al. (2007). "Contextual modulation involves
% suppression and facilitation from the center and the surround." Journal
% of Vision 7(4): 21.].
%
% Extra (doIt_crossOriented.m): Replotting of other data from the same
% paper to show how cross-oriented overlay masks at different contrasts can
% either facilitate or suppress contrast perception at threshold.

clear all
close all
%% Meese's data (observer RJS)
meeseC_dB       = [-inf 8 14 20 30];
meeseT_dB       = [8.93150684931507 -1.2054794520547922 2.7945205479452078 5.698630136986306 11.780821917808222];
meeseTmasked_dB = [4.986301369863018 0.43835616438356695 6.849315068493151 12.602739726027398 16.547945205479454];

meeseC       = 10.^(meeseC_dB./20);
meeseT       = 10.^(meeseT_dB./20);
meeseTmasked = 10.^(meeseTmasked_dB./20);


%% Meese's parameters (observer RJS)
param.p = 3.11;
param.q = 2.59;
param.z = 32.87;
param.a = 0.323;
param.b = 0.494;
param.k = 0.436;

%% Other variables
% Contrast range
c = [exp(linspace(log(0.1),log(1),100)) exp(linspace(log(1),log(100),200))]; c = sort(unique(c));

%% Contrast response function (CRF) and corresponding threshold vs contrast (TvC) function according to signal detection theory
rc = transducerFun(c,param);
tc = SDT(c,rc,param);

fr = figure('windowstyle','docked');
plot(c,rc,'k'); hold on
title('CRF')
ft = figure('windowstyle','docked');
plot(log(c/100),log(tc/100),'k'); hold on
title('TvC')

% Visualize how thresholds derive from contrast response function
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

% xMax = cPedInc*1.1;
xMax = 35;
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
if c(1)~=0
    c = [0 c];
end
% Set masks
cX = [0 10 75];
% Compute CRF and TvC
rc = nan(length(cX),length(c));
tc = nan(length(cX),length(c));
for i = 1:length(cX)
    rc(i,:)= transducerFun(c,param,cX(i));
    tc(i,:) = SDT(c,rc(i,:),param);
end
%deal with 0% pedestral contrast seperatly to avoid infinity
if c(1)==0
    c0 = c(:,1);
    c(:,1) = [];
    rc0 = rc(:,1);
    rc(:,1) = [];
    tc0 = tc(:,1);
    tc(:,1) = [];
end

% Plot
fX = figure('windowstyle','docked');
axr = subplot(2,1,2);
% hr = semilogy(log(c/100),rc); hold on
hr = plot(log(c/100),rc); hold on
legLabel = {'pedestal only' '+ 10% mask' '+ 75% mask'};
hLeg = legend(legLabel,'location','best','box','off');
% hLeg = legend(cellstr([num2str(cX') repmat('%',length(cX),1)]),'location','best');
% title(hLeg,'mask contrast')
ylabel({'transducer response' '(a.u.)'})
xlabel('pedestal  ( log(contrast) )')
% xlabel({'pedestal' '( log(contrast) )'})
axis tight
drawnow
xlim([log(min(c)/100) log(max(c)/100)])
xlim([log(min(c)/100) log(xMax/100)]); drawnow
title('Contrast Response Function')
tickMin = ceil(axr.XTick(1)/delta)*delta;
tickMax = floor(axr.XTick(end)/delta)*delta;
axr.XTick = tickMin:delta:tickMax;
box off

axt = subplot(2,1,1);
ht = plot(log(c/100),log(tc/100)); hold on
for i = 1:length(ht)
    ht0(i) = plot(log(c([1 end])/100),[1 1].*log(tc0(i)/100),':','color',ht(i).Color); hold on
end
% hLeg = legend(ht,cellstr([num2str(cX') repmat('%',length(cX),1)]),'location','best');
% title(hLeg,'mask contrast')
ylabel({'contrast increment threshold' '( log(contrast) )'})
axis tight
xlim([log(min(c)/100) log(xMax/100)]); drawnow
axt.DataAspectRatio = [1 1 1];
xlim([log(min(c)/100) log(xMax/100)]); drawnow
title('Threshold vs Contrast Function')

delta = 1;
tickMin = ceil(axt.YTick(1)/delta)*delta;
tickMax = floor(axt.YTick(end)/delta)*delta;
axt.YTick = tickMin:delta:tickMax;
tickMin = ceil(axt.XTick(1)/delta)*delta;
tickMax = floor(axt.XTick(end)/delta)*delta;
axt.XTick = tickMin:delta:tickMax;
box off

axr.PlotBoxAspectRatio = axt.PlotBoxAspectRatio; drawnow
axr.XLim = axt.XLim; drawnow
axr.YTickLabel = [];

set([axr axt],'TickDir','out')

set([hr(1) ht(1)],'color','k')
set([hr(2) ht(2)],'color','r')

set(gcf,'color','w')


% ht0 = plot(xlim,[1 1].*log(tc0/100),'k:');

tmp = log(meeseT(1)/100);
yMin = min(ylim);
xMin = min(xlim);
x = [xMin tmp tmp  xMin];
y = [tmp  tmp yMin yMin];


% Add meese's data
axes(axt)
scatter([xMin log(meeseC(2:end)/100)],log(meeseT/100),'ok')
scatter([xMin log(meeseC(2:end)/100)],log(meeseTmasked/100),'or')


% Change to %contrast axis
xPerc = [0.1:0.1:1 1:10 10:10:30]; xPerc = sort(unique(xPerc));
axt.XTick = log(xPerc/100);
xPercLabel = cellstr(num2str(xPerc'));
xPercLabel(~ismember(xPerc,[1 10])) = {''};
axt.XTickLabel = xPercLabel;
axt.XTickLabelRotation = 0;
axt.XAxis.Label.String = 'pedestal  ( %contrast) )';


delta = 1;
yPerc = round(exp(axt.YLim)*100/delta)*delta;
yPerc = yPerc(1):delta:yPerc(2);
axt.YTick = log(yPerc/100);
yPercLabel = cellstr(num2str(yPerc'));
% delta = 1;
% yPercLabel(~ismember(yPerc,unique(round(yPerc/delta).*delta))) = {''};
axt.YTickLabel = yPercLabel;
axt.YAxis.Label.String = {'contrast increment threshold' '(%contrast)'};



xlabel('pedestal %contrast')

delta = 1;
tickMin = ceil(axr.YLim(1)/delta)*delta;
tickMax = floor(axr.YLim(end)/delta)*delta;
axr.YTick = tickMin:delta:tickMax;

% axr.YTick = [0.0001    0.0100    1.0000  100.0000];

for i = 1:length(ht0)
    ht0(i).Color = ht(i).Color;
end



return
%% Export figures
curF = fr;
fullfilename = fullfile(pwd,'CRFandSDT');
figure(curF)
curF.WindowStyle = 'normal';
curF.Color = 'none';
set(findobj(curF.Children,'type','Axes'),'color','none')
drawnow
% curFile = fullfilename;
% curExt = 'eps';
% exportgraphics(curF,[curFile '.' curExt],'ContentType','vector'); disp([curFile '.' curExt]);
curExt = 'svg';
saveas(curF,[fullfilename '.' curExt]); disp([fullfilename '.' curExt])
curF.Color = 'w';
curExt = 'fig';
saveas(curF,[fullfilename '.' curExt]); disp([fullfilename '.' curExt]);
curExt = 'jpg';
saveas(curF,[fullfilename '.' curExt]); disp([fullfilename '.' curExt]);


curF = fX;
fullfilename = fullfile(pwd,'CRFandCvT');
figure(curF)
curF.WindowStyle = 'normal';
curF.Color = 'none';
set(findobj(curF.Children,'type','Axes'),'color','none')
drawnow
ax = findobj(curF.Children,'type','axes');
ax(1).Position([1 3]) = ax(2).Position([1 3])
drawnow
% curFile = fullfilename;
% curExt = 'eps';
% exportgraphics(curF,[curFile '.' curExt],'ContentType','vector'); disp([curFile '.' curExt]);
curExt = 'svg';
saveas(curF,[fullfilename '.' curExt]); disp([fullfilename '.' curExt])
curF.Color = 'w';
curExt = 'fig';
saveas(curF,[fullfilename '.' curExt]); disp([fullfilename '.' curExt]);
curExt = 'jpg';
saveas(curF,[fullfilename '.' curExt]); disp([fullfilename '.' curExt]);





