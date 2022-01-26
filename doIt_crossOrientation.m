% Replotting of data and fits from [Meese, T. S., et al. (2007).
% "Contextual modulation involves suppression and facilitation from the
% center and the surround." Journal of Vision 7(4): 21.] to show how
% cross-oriented overlay masks at different contrasts can either facilitate
% or suppress contrast perception at threshold.
%
% By Sébastien Proulx, sebastien.proul2@mail.mcgill.ca, https://orcid.org/0000-0003-1709-3277 
% License: CC-BY 4.0 (https://creativecommons.org/licenses/by/4.0/)
% Published on GitHub (https://github.com/farivarlab/psychoCRFdemo)



clear all
close all
%% Meese's data
% 1 & 1 c/deg (observer DHB)
meese1C_dB  = [2.9868995633187794 9.039301310043669 15.091703056768562 21.14410480349345 27.10480349344978 33.06550218340612];
meese1T_dB  = [-0.6164383561643838 -0.3527397260273961 1.0034246575342465 2.698630136986301 5.825342465753423 7.595890410958903];
meese1T0_dB = -1.6712328767123292;
meese1Cf_dB = [-8.896869982	-8.14715312	-7.397436259	-6.647719397	-5.898002536	-5.148285674	-4.398568813	-3.648851951	-2.899135089	-2.149418228	-1.399701366	-0.649984505	0.099732357	0.849449218	1.59916608	2.068240266	2.757819411	4.257253134	5.006969996	5.756686857	6.506403719	7.25612058	8.005837442	8.448851951	8.813973799	9.121893224	9.505271165	10.22090999	10.93654881	11.68626567	12.43598253	13.18569939	13.92632878	14.68513312	15.43484998	16.18456684	16.90020566	17.61584449	18.39623158	19.06984082	19.92513279	20.64699639	21.30114101	22.79570644	23.5454233	24.29514016	25.04485702	25.79457388	27.64127905	28.36877653	29.13422172	31.24706015	32.57920168	33.32014086	34.79117622	35.40458093];
meese1Tf_dB = [-2.714215643	-2.691307998	-2.62003977	-2.604768007	-2.590768891	-2.49150243	-2.42450666	-2.369837384	-2.210883783	-2.153741935	-2.084509943	-1.880631905	-1.779547377	-1.646973928	-1.442841361	-1.261308674	-1.14885992	-0.796336721	-0.661981567	-0.426360078	-0.219827662	-0.049292974	0.206509059	-0.192624834	0.330792122	0.026236349	0.598484313	0.828260716	1.112209456	1.303530711	1.568241273	1.832648823	1.989487406	2.226381542	2.475396124	2.676656145	2.905696231	3.220136986	3.316703617	3.527390316	3.747003903	3.954275647	4.203347642	4.711679187	4.910212108	5.250008838	5.442178524	5.622076258	6.342805697	6.515233314	6.723006755	7.405872735	7.644494034	7.953110915	8.350903983	8.613640643];
% 7 & 7 c/deg (observer DJH)
meese7C_dB  = [2.791443850267381 8.759358288770056 14.823529411764707 20.88770053475936 26.85561497326203 32.91978609625668];
meese7T_dB  = [5.841269841269841 7.468253968253968 3.7777777777777786 3.817460317460318 4.928571428571428 6.7936507936507935];
meese7T0_dB = 8.1750;
meese7Cf_dB = [-8.815138206	-8.06527628	-7.315414354	-6.565552429	-5.679351971	-4.929490045	-4.17962812	-3.429766194	-2.679904268	-1.930042343	-1.180180417	-0.430318491	0.319543434	1.06940536	1.819267286	2.516108671	3.318991137	4.068853063	4.818714988	5.568576914	6.31843884	7.068300765	7.792599216	8.568024617	9.317886542	10.06774847	10.81761039	11.56747232	12.31733425	13.06719617	13.8170581	14.56692002	15.31678195	16.06664387	16.8165058	17.56636772	18.31622965	19.06609158	19.8159535	20.56581543	21.31567735	22.06553928	23.29258607	24.04244799	24.79230992	25.54217184	26.28445941	26.97372643	27.72358835	28.47345028	29.22331221	29.97317413	30.72303606	31.40472872	32.05233674	34.88136128	35.59713857];
meese7Tf_dB = [7.640980667	7.595314036	7.59339527	7.547344885	7.51152792	7.493619437	7.436056456	7.421985505	7.375935121	7.314534608	7.25569245	7.191733583	7.127774716	7.066374203	7.001136158	6.956507082	6.887289374	6.804142847	6.694133595	6.614824599	6.511211234	6.410156224	6.324291445	6.222117154	6.117224612	5.979073458	5.9202313	5.759054954	5.643928993	5.556944934	5.411118716	5.284480159	5.156562424	5.032482221	4.918635438	4.852118216	4.79199688	4.72931719	4.705652409	4.67623133	4.681987628	4.669195855	4.701175289	4.763854979	4.831651378	4.948056517	5.096014696	5.27424674	5.344601494	5.553107402	5.762892486	6.016169601	6.312938746	6.562520459	6.774210097	7.803180355	8.082808523];

% clean
maxC = min([max(meese1Cf_dB) max(meese7Cf_dB)]);
meese1Tf_dB = meese1Tf_dB(meese1Cf_dB<maxC);
meese1Cf_dB = meese1Cf_dB(meese1Cf_dB<maxC);
meese7Tf_dB = meese7Tf_dB(meese7Cf_dB<maxC);
meese7Cf_dB = meese7Cf_dB(meese7Cf_dB<maxC);

% smooth out the data extraction errors
% f = figure('windowstyle','docked');
% hScat1 = scatter(meese1C_dB,meese1T_dB); hold on
% plot(meese1Cf_dB,meese1Tf_dB)
f = fit(meese1Cf_dB',meese1Tf_dB','smoothingspline','SmoothingParam',0.07);
meese1Tf_dB  = f(meese1Cf_dB)';
% plot(meese1Cf_dB,meese1Tf_dB)
% plot(xlim,[1 1].*meese1T0_dB)

% f = figure('windowstyle','docked');
% hScat1 = scatter(meese7C_dB,meese7T_dB); hold on
% plot(meese7Cf_dB,meese7Tf_dB)
f = fit(meese7Cf_dB',meese7Tf_dB','smoothingspline','SmoothingParam',0.07);
meese7Tf_dB  = f(meese7Cf_dB)';
% plot(meese7Cf_dB,meese7Tf_dB)
% plot(xlim,[1 1].*meese7T0_dB)

% convert to contrast
meese1C  = 10.^(meese1C_dB./20) / 100;
meese1T  = 10.^(meese1T_dB./20) / 100;
meese1T0 = 10.^(meese1T0_dB./20) / 100;
meese1Cf  = 10.^(meese1Cf_dB./20) / 100;
meese1Tf  = 10.^(meese1Tf_dB./20) / 100;

meese7C  = 10.^(meese7C_dB./20) / 100;
meese7T  = 10.^(meese7T_dB./20) / 100;
meese7T0 = 10.^(meese7T0_dB./20) / 100;
meese7Cf  = 10.^(meese7Cf_dB./20) / 100;
meese7Tf  = 10.^(meese7Tf_dB./20) / 100;

% log it
meese1C  = log(meese1C);
meese1T  = log(meese1T);
meese1T0 = log(meese1T0);
meese1Cf = log(meese1Cf);
meese1Tf = log(meese1Tf);

meese7C  = log(meese7C);
meese7T  = log(meese7T);
meese7T0 = log(meese7T0);
meese7Cf = log(meese7Cf);
meese7Tf = log(meese7Tf);

%% Make plots
c0 = -5.25;
f = figure('windowstyle','docked');
tmp0 = interp1(meese1Tf,meese1Cf,meese1T0);
ind = meese1Cf>tmp0 & meese1Tf>meese1T0;
ind = ind & (meese1Cf > (meese1C(1)-(meese1Cf(end) - meese1C(end))));
meese1Tf_tmp  =meese1Tf(ind);
meese1Cf_tmp  =meese1Cf(ind);
hPlot1 = plot(meese1Cf_tmp,meese1Tf_tmp); hold on
xP = [meese1Cf_tmp meese1Cf_tmp(end) meese1Cf_tmp(1)];
yP = [meese1Tf_tmp meese1T0          meese1T0];
hPatch1 = patch(xP,yP,hPlot1.Color); alpha(hPatch1,0.05)
hPatch1.LineStyle = 'none';
hPlot1_scat = plot([c0 meese1C],[meese1T0 meese1T],'o','Color',hPlot1.Color,'MarkerFaceColor','w');
hPlot1_base = plot([c0 meese1Cf(end)],[meese1T0 meese1T0],':','Color',hPlot1.Color,'MarkerFaceColor','w');


ind = true(size(meese7Cf));
ind = ind & (meese7Cf > (meese7C(1)-(meese7Cf(end) - meese7C(end))));
meese7Tf_tmp  =meese7Tf(ind);
meese7Cf_tmp  =meese7Cf(ind);
hPlot7 = plot(meese7Cf_tmp,meese7Tf_tmp);
xP = [meese7Cf_tmp meese7Cf_tmp(end) meese7Cf_tmp(1)];
yP = [meese7Tf_tmp meese7T0          meese7T0];
hPatch7 = patch(xP,yP,hPlot7.Color); alpha(hPatch7,0.05)
hPatch7.LineStyle = 'none';
hPlot7_scat = plot([c0 meese7C],[meese7T0 meese7T],'o','Color',hPlot7.Color,'MarkerFaceColor','w');
hPlot7_base = plot([c0 meese7Cf(end)],[meese7T0 meese7T0],':','Color',hPlot7.Color,'MarkerFaceColor','w');


% beautify
ax = gca;
yLim = [meese1T0 meese7T0];
yLim = [min(yLim) max(yLim)];
yLim = yLim + [-1 1].*0.1.*range(yLim);
ylim(yLim)
xLim = xlim;
xLim(2) = meese1Cf(end);
xlim(xLim);
box off



XTick_perc = 1:max(exp(xLim)*100);
XTick = log(XTick_perc/100);
ax.XTick = XTick; XTick = ax.XTick;
XTickLabel = cellstr(num2str((exp(XTick)*100)'));
XTickLabel(~ismember(XTick_perc,10:10:max(exp(xLim)*100))) = {''};
ax.XTickLabel = XTickLabel;
ax.XTickLabelRotation = 0;

YTick_perc = 0.1:0.1:max(exp(yLim)*100);
YTick = log(YTick_perc/100);
ax.YTick = YTick; YTick = ax.YTick;
YTickLabel = cellstr(num2str((exp(YTick)*100)'));
YTickLabel(~ismember(YTick_perc,1:1:max(exp(yLim)*100))) = {''};
ax.YTickLabel = YTickLabel;

ax.TickDir = 'out';

xlabel('Cross-Oriented Overlay Mask Contrast (%contrast)')
ylabel('Contrast Detection Threshold (%contrast)')

ax.PlotBoxAspectRatio = [1 1 1];
uistack([hPlot1_scat hPlot1_base hPlot7_scat hPlot7_base],'top')

legend([hPlot1_scat hPlot7_scat hPatch1 hPatch7],{'large 1cpd grating' 'small 7cpd grating' 'suppression' 'facilitation'},'box','off','location','west')

return
%% Export figures
curF = f;
fullfilename = fullfile(pwd,'XorTvC');
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


