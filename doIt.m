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

c = [exp(linspace(log(0.1),log(1),100)) exp(linspace(log(1),log(50),50))];
% c = [exp(linspace(log(0.01),log(0.1),100)) exp(linspace(log(0.1),log(1),100)) exp(linspace(log(1),log(100),100))];


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
plot(cTmp,resp2); hold on
plot(cTmp,resp3); hold on


figure('windowstyle','docked')
cTmp = log(c);
plot(cTmp,log(resp)); hold on
plot(cTmp,log(resp2)); hold on
plot(cTmp,log(resp3)); hold on

