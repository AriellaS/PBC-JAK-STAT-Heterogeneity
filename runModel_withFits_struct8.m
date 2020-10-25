% Ryland Mortlock
% June 5th, 2020

clear all
close all
type = 'weighted';

Data_time = importdata('tspan.mat');

%--- Model prediction timepoints
predTime = [0:60:24*3600];

Data_time_minutes = Data_time./60;
predTime_minutes =predTime./60;
Data_time_hours = Data_time_minutes./60;
predTime_hours =predTime_minutes./60;
pStat_hours = predTime_hours(1:361);

%--- Load experimental data
Exp_data = importdata('Exp_data_new.mat');

%--- Get free param values from analyze_fits.m
ALL_params = importdata('free_params_struct8.mat');

%--- select param set with lowest error
 var = 1115;
selected_paramSet = ALL_params(var,:);
free_params1 = selected_paramSet(1,:);

%--- load free init values
free_initValues = importdata('data/samples/free_initValues.mat');
num_samples = length(free_initValues);

%% Run with best fit (PRL stimulation)

% Assign the fitted parameter values
k3 = free_params1(1);
k5 = free_params1(2);
deg_ratio = free_params1(3);
k8A = free_params1(4);
mult8B = free_params1(5);
mult8AB = free_params1(6);
k9 = free_params1(7);
k11 = free_params1(8);
k_13 = free_params1(9);
k14A = free_params1(10);
mult14B = free_params1(11);
mult14AB = free_params1(12);
k15 = free_params1(13);
k16 = free_params1(14);
k17outA = free_params1(15);
mult17B = free_params1(16);
k19 = free_params1(17);
k21 = free_params1(18);
k22 = free_params1(19);
k23 = free_params1(20);
k24 = free_params1(21);
k25a = free_params1(22);
k27 = free_params1(23);
k28 = free_params1(24);
totalSTAT = free_params1(25);
k30a = free_params1(26);
RJ = free_params1(27);
SHP2 = free_params1(28);
PPX = free_params1(29);
PPN = free_params1(30);

k34 = free_params1(31);
BCL = free_params1(32);
k4 = free_params1(33);

% Calculate based on multiplication ratios
k8B = mult8B*k8A;
k8AB = mult8AB*k8A;
k14B = mult14B*k14A;
k14AB = mult14AB*k8A;
k17outB = mult17B*k17outA;

% Assign to parameter values
params(4,1) = k3;
params(7,1) = k5;
params(11,1) = deg_ratio;
params(12,1) = k8A;
params(14,1) = k8B;
params(16,1) = k8AB;
params(18,1) = k9;
params(21,1) = k11;
params(25,1) = k_13;
params(26,1) = k14A;
params(27,1) = k14B;
params(28,1) = k14AB;
params(29,1) = k15;
params(31,1) = k16;
params(33,1) = k17outA;
params(35,1) = k17outB;
params(38,1) = k19;
params(40,1) = k21;
params(42,1) = k22;
params(43,1) = k23;
params(44,1) = k24;
params(45,1) = k25a;
params(48,1) = k27;
params(49,1) = k28;
params(54,1) = totalSTAT;
params(55,1) = k30a;

initvalues(2,1) = RJ;
initvalues(5,1) = SHP2;
initvalues(6,1) = PPX;
initvalues(7,1) = PPN;

params(60,1) = k34;
initvalues(56,1) = BCL;
params(6,1) = k4;


% Parameter values
params(2,1) = 0.000056;
params(3,1) = 0.0056;
%                 params(4,1) = 0.04;
params(5,1) = 0.2;
%                params(6,1) = 0.005;
%                 params(7,1) = 0.008;
params(8,1) = 0.8;
params(9,1) = 0.4;
params(10,1) = 0.000256721177985165;
%                 params(11,1) = 10;
%                 params(12,1) = 0.02;
params(13,1) = 0.1;
%                 params(14,1) = 0.02;
params(15,1) = 0.1;
%                 params(16,1) = 0.02;
params(17,1) = 0.1;
%                 params(18,1) = 0.001;
params(19,1) = 0.2;
params(20,1) = 0.003;
%                 params(21,1) = 0.001;
params(22,1) = 0.2;
params(23,1) = 0.003;
params(24,1) = 0.0000002;
%                 params(25,1) = 0.2;
%                 params(26,1) = 0.005;
%                 params(27,1) = 0.005;
%                 params(28,1) = 0.005;
%                 params(29,1) = 0.001;
params(30,1) = 0.2;
%                 params(31,1) = 0.005;
params(32,1) = 0.0355;
%                 params(33,1) = 0.05;
params(34,1) = 0.0355;
%                 params(35,1) = 0.05;
params(36,1) = 0.01;
params(37,1) = 400;
%                 params(38,1) = 0.001;
params(39,1) = 0.01;
%                 params(40,1) = 0.02;
params(41,1) = 0.1;
%                 params(42,1) = 0.0005;
%                 params(43,1) = 0.0005;
%                 params(44,1) = 0.0005;
%                 params(45,1) = 0.01;
params(46,1) = 400;
params(47,1) = 0.001;
%                 params(48,1) = 0.0005;
%                 params(49,1) = 0.01;
params(50,1) = 0.01;
params(51,1) = 0.5;
params(52,1) = 1.2;
params(53,1) = 1.36;
%                 params(54,1) = 1000;
%                 params(55,1) = 0.01;
params(56,1) = 400;
params(57,1) = 0.001;
params(58,1) = 0.0005;
params(59,1) = 0.01;
%                 params(60,1) = 1.92540883488874E-05;
params(61,1) = 0;


% Initial values from Yamada 2003
initvalues(1,1)= 9.09;
% initvalues(2,1)= 12;
initvalues(3,1)= 0;
initvalues(4,1)= 0;
% initvalues(5,1)= 100;
% initvalues(6,1)= 50;
% initvalues(7,1)= 60;
initvalues(8,1)= 0;
initvalues(9,1)= 0;
initvalues(10,1)= 0;
initvalues(11,1)= 0;
initvalues(12,1)= 0;
initvalues(13,1)= 0;
initvalues(14,1)= 0;
initvalues(15,1)= 0;
initvalues(16,1)= 0;
initvalues(17,1)= 0;
initvalues(18,1)= 0;
initvalues(19,1)= 0;
initvalues(20,1)= 0;
initvalues(21,1)= 0;
initvalues(22,1)= 0;
initvalues(23,1)= 0;
initvalues(24,1)= 0;
initvalues(25,1)= 0;
initvalues(26,1)= 0;
initvalues(27,1)= 0;
initvalues(28,1)= 0;
initvalues(29,1)= 0;
initvalues(30,1)= 0;
initvalues(31,1)= 0;
initvalues(32,1)= 0;
initvalues(33,1)= 0;
initvalues(34,1)= 0;
initvalues(35,1)= 0;
initvalues(36,1)= 0;
initvalues(37,1)= 0;
initvalues(38,1)= 0;
initvalues(39,1)= 0;
initvalues(40,1)= 0;
initvalues(41,1)= 0;
initvalues(42,1)= 0;
initvalues(43,1)= 0;
initvalues(44,1)= 0;
initvalues(45,1)= 0;
initvalues(46,1)= 0;
initvalues(47,1)= 0;
initvalues(48,1)= 0;
initvalues(49,1)= 0;
initvalues(50,1)= 0;
initvalues(51,1)= 0;
initvalues(52,1)= 0;
initvalues(53,1)= 0;
initvalues(54,1) = 0;
initvalues(55,1) = 0;
%                 initvalues(56,1) = 50;


% Assign variables for calculated quantities
kdeg = params(10,1);
RJ = initvalues(2,1);

Vratio = params(51,1);
ncratioA = params(52,1);
ncratioB = params(53,1);
totalSTAT = params(54,1);

k17outA = params(33,1);
k17outB = params(35,1);

k34 = params(60,1);
BCL = initvalues(56,1);

% Calculate quantities
ksyn = kdeg*RJ; % syn rate of RJ
S5Ac = totalSTAT/(1 + ncratioA*Vratio); % STAT5 in cytosol
S5An = (totalSTAT - S5Ac)/Vratio; %STAT5 in nucleus
S5Bc = totalSTAT/(1 + ncratioB*Vratio); % STAT5 in cytosol
S5Bn = (totalSTAT - S5Bc)/Vratio; %STAT5 in nucleus
k17inA = S5An/S5Ac*(Vratio)*k17outA;
k17inB = S5Bn/S5Bc*(Vratio)*k17outB;
k35 = k34*BCL;

%Assign them
params(1,1) = ksyn;
initvalues(3,1) = S5Ac;
initvalues(35,1) = S5An;
initvalues(4,1) = S5Bc;
initvalues(36,1) = S5Bn;
params(32,1) = k17inA;
params(34,1) = k17inB;
params(61,1) = k35;

% Set options

options = odeset('RelTol',1e-9,'AbsTol',1e-12,'NonNegative',[1:length(initvalues)]);

% simulate the model

parfor n = 1 : num_samples
	selected_initvalues = initvalues;
	selected_initvalues(2,1) = free_initValues(n,1);
	selected_initvalues(5,1) = free_initValues(n,2);
	selected_initvalues(6,1) = free_initValues(n,3);
	selected_initvalues(7,1) = free_initValues(n,4);

	[~, predConc] = ode15s(@core_file_struct8,predTime,selected_initvalues,options,params);
	results(n,:,:) = predConc;
end

% Calculated quantities

cytosolic_pStatA = results(:,:,13) + 2.*results(:,:,15) + results(:,:,16) + results(:,:,19) + 2*results(:,:,21) + results(:,:,23) + results(:,:,24) + results(:,:,27);
cytosolic_pStatB = results(:,:,14) + 2.*results(:,:,17) + results(:,:,16) + results(:,:,20) + 2*results(:,:,22) + results(:,:,23) + results(:,:,25) + results(:,:,26);

nuclear_pStatA = 2*results(:,:,28) + results(:,:,29) + results(:,:,31) + results(:,:,33) + 2*results(:,:,37) + results(:,:,38) + results(:,:,40) + results(:,:,43);
nuclear_pStatB = 2*results(:,:,30) + results(:,:,29) + results(:,:,32) + results(:,:,34) + 2*results(:,:,39) + results(:,:,38) + results(:,:,41) + results(:,:,42);

npA_ratio_cpA = nuclear_pStatA./cytosolic_pStatA;
npB_ratio_cpB = nuclear_pStatB./cytosolic_pStatB;

total_pStatA = results(:,:,13) +2.*results(:,:,15) + results(:,:,16) + results(:,:,19) + 2*results(:,:,21) + results(:,:,23) + results(:,:,24) + results(:,:,27) + 2*results(:,:,28) + results(:,:,29) + results(:,:,31) + results(:,:,33) + 2*results(:,:,37) + results(:,:,38) + results(:,:,40) + results(:,:,43);
total_pStatB = results(:,:,14) +2.*results(:,:,17) + results(:,:,16) + results(:,:,20) + 2*results(:,:,22) + results(:,:,23) + results(:,:,25) + results(:,:,26) + 2*results(:,:,30) + results(:,:,29) + results(:,:,32) + results(:,:,34) + 2*results(:,:,39) + results(:,:,38) + results(:,:,41) + results(:,:,42);

% pStatA_norm(:,:,i) = total_pStatA(:,:,i)./total_pStatA(31,i);% normalized to 30 minute
% pStatB_norm(:,:,i) = total_pStatB(:,:,i)./total_pStatB(31,i);% normalized to 30 minute

cytosolic_statA = results(:,:,3) + results(:,:,11) + results(:,:,13) + 2*results(:,:,15) + results(:,:,16) + results(:,:,19) + 2*results(:,:,21) + results(:,:,23) + 2*results(:,:,24) + results(:,:,26) + results(:,:,27) + results(:,:,48);
cytosolic_statB = results(:,:,4) + results(:,:,12) + results(:,:,14) + 2*results(:,:,17) + results(:,:,16) + results(:,:,20) + 2*results(:,:,22) + results(:,:,23) + 2*results(:,:,25) + results(:,:,26) + results(:,:,27) + results(:,:,49);

nuclear_statA = 2*results(:,:,28) + results(:,:,29) + results(:,:,31) + results(:,:,33) + results(:,:,35) + 2*results(:,:,37) + results(:,:,38) + 2*results(:,:,40) + results(:,:,42) + results(:,:,43);
nuclear_statB = 2*results(:,:,30) + results(:,:,29) + results(:,:,32) + results(:,:,34) + results(:,:,36) + 2*results(:,:,39) + results(:,:,38) + 2*results(:,:,41) + results(:,:,42) + results(:,:,43);

% total_statA = nuclear_statA*Vratio + cytosolic_statA;
% total_statB = nuclear_statB*Vratio + cytosolic_statB;

npAcpA_ratio_totA = (nuclear_pStatA*Vratio + cytosolic_pStatA)./totalSTAT;
npBcpB_ratio_totB = (nuclear_pStatB*Vratio + cytosolic_pStatB)./totalSTAT;

% nucleus_cyto_ratioA(:,i) = Stat_nucleusA(:,i)./Stat_cytoA(:,i);
% nucleus_cyto_ratioB(:,i) = Stat_nucleusB(:,i)./Stat_cytoB(:,i);

% transloc_predA(:,i) = nucleus_cyto_ratioA(:,i);
% transloc_predB(:,i) = nucleus_cyto_ratioB(:,i);

% rec_total(:,i) = predConc(:,2) + predConc(:,8) + 2*predConc(:,9) + 2*predConc(:,10) + 2*predConc(:,11) + 2*predConc(:,12) + 2*predConc(:,18) + 2*predConc(:,47) + 2*predConc(:,48) + 2*predConc(:,49) + 2*predConc(:,50);
% rec_internalized = 1 - rec_total(:,i)./initvalues(2);
% intern_pred(i) = rec_internalized(31);

% Bcl fold change
% Bcl(:,i) = predConc(:,56)./predConc(1,56);

 % pJAK2
% total_pJAK2 = predConc(:,10) + predConc(:,11)+ predConc(:,12)+ predConc(:,18)+ predConc(:,47)+ predConc(:,48)+ predConc(:,49)+ predConc(:,50);
% pJAK2_norm(:,i) = total_pJAK2./total_pJAK2(11); %Normalized to 10 minute



%% Plot results

% cols = cbrewer('qual','Paired',10);
% my_cols(3,:) = cols(10,:); % Purple
%
% cols = cbrewer('seq','Blues',8);
% my_cols(1,:) = cols(6,:); % Light blue
% my_cols(2,:) = cols(8,:); % Dark blue
%
% %--- plot pStatA with 95% CI
% f = figure('visible','off');
% for i = 1:numFits
% plot(pStat_hours,pStatA_norm(1:361,i),'-','color',my_cols(1,:),'LineWidth',2)
% hold on;
% end
% % Experimental data
% scatter([Data_time_hours(3) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(10) Data_time_hours(12)],Exp_data(1:6),48,'MarkerEdgeColor',my_cols(1,:),'Marker','s','Linewidth',1,'MarkerFaceColor',[1 1 1])
%
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
%
% xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
% ylabel('Phosph. STAT5A','FontSize',14,'FontWeight','bold','Color','k')
%
% % Save it
% saveas(f,strcat('figures/','pSTATA','.png'))
%
%
% %--- plot pStatB
% f = figure('visible','off');
% for i = 1:numFits
% plot(pStat_hours,pStatB_norm(1:361,i),'-','color',my_cols(2,:),'LineWidth',2)
% hold on;
% end
%
% % Experimental data
% Data_time2 = [Data_time_hours(3) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(10) Data_time_hours(12)]; 
% scatter(Data_time2,Exp_data(7:12),48,'MarkerEdgeColor',my_cols(2,:),'Marker','s','Linewidth',1,'MarkerFaceColor',[1 1 1])
%
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
%
% xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
% ylabel('Phosph. STAT5B','FontSize',14,'FontWeight','bold','Color','k')
%
% % Save it
% saveas(f,strcat('figures/','pSTATB','.png'))
%
%
% %--- plot translocation prediction A
% f = figure('visible','off');
% for i = 1:numFits
% plot(pStat_hours,transloc_predA(1:361,i),'-','color',my_cols(1,:),'LineWidth',2)
% hold on;
% end
%
% % Experimental data
% Data_time3 = [Data_time_hours(5) Data_time_hours(6) Data_time_hours(7) Data_time_hours(9) Data_time_hours(12)];
% scatter(Data_time3,Exp_data(13:17),48,'MarkerEdgeColor',my_cols(1,:),'Marker','s','Linewidth',1,'MarkerFaceColor',[1 1 1])
%
% error3 = [0.1919942;
% 0.1599941
% 0.1728005
% 0.1472004
% 0.1664005];
%
% errorbar(Data_time3, Exp_data(13:17), error3, 'LineStyle','none','Color',my_cols(1,:));
%
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
%
%
% %--- plot translocation prediction B
% for i = 1:numFits
% plot(pStat_hours,transloc_predB(1:361,i),'-','color',my_cols(2,:),'LineWidth',2)
% hold on;
% end
%
% % Experimental data
% Data_time4 = [Data_time_hours(2) Data_time_hours(4) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(9) Data_time_hours(10) Data_time_hours(11) Data_time_hours(12)];
% scatter(Data_time4,Exp_data(18:26),48,'MarkerEdgeColor',my_cols(2,:),'Marker','s','Linewidth',1,'MarkerFaceColor',[1 1 1])
%
% error4 = [0.3967948;
% 0.4832015
% 0.5312016
% 0.4576015
% 0.4031949
% 0.4191949
% 0.3583887
% 0.336001
% 0.3711886];
%
% errorbar(Data_time4, Exp_data(18:26), error4, 'LineStyle','none','Color',my_cols(2,:));
%
%
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
%
% % title('STAT5B','FontSize',18,'FontWeight','bold','Color','k');
% xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k');
% ylabel('Nucleus/cyto. ratio','FontSize',14,'FontWeight','bold','Color','k');
%
% % Save it
% saveas(f,strcat('figures/','translocation_predictions','.png'))
%
% % Plot Bcl
% f = figure('visible','off');
% for i = 1:numFits
% plot(predTime_hours,Bcl(1:1441,i),'-','color',my_cols(3,:),'LineWidth',2)
% hold on;
% end
%
% % Experimental data
% Data_time5 = [Data_time_hours(8) Data_time_hours(10) Data_time_hours(12) Data_time_hours(13) Data_time_hours(14) Data_time_hours(15) Data_time_hours(16)];
% scatter(Data_time5,Exp_data(27:33),48,'MarkerEdgeColor',my_cols(3,:),'Marker','s','Linewidth',1,'MarkerFaceColor',[1 1 1])
%
% error5 = [0.0594048;
% 0.0891216
% 0.0593759
% 0.0630888
% 0.2153281
% 0.2004768
% 0.1893241];
%
% errorbar(Data_time5, Exp_data(27:33), error5, 'LineStyle','none','Color',my_cols(3,:));
%
%
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
%
% % title('STAT5B','FontSize',18,'FontWeight','bold','Color','k');
% xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
% ylabel('Bcl-xL fold change','FontSize',14,'FontWeight','bold','Color','k')
%
% % Save it
% saveas(f,strcat('figures/','BCL_fold_change','.png'))
%
%
%
% %--- plot pJAK2
% f = figure('visible','off');
% for i = 1:numFits
% plot(pStat_hours,pJAK2_norm(1:361,i),'-','color',my_cols(1,:),'LineWidth',2)
% hold on;
% end
%
% % Experimental data
% scatter([Data_time_hours(3) Data_time_hours(5) Data_time_hours(6) Data_time_hours(8) Data_time_hours(10) Data_time_hours(12)],Exp_data(34:39),48,'MarkerEdgeColor',my_cols(1,:),'Marker','s','Linewidth',1,'MarkerFaceColor',[1 1 1])
%
% box off;
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 12;
% set(gcf,'color','w');
% ax.TickDir = 'out';
% ax.XGrid = 'off';
% ax.YGrid = 'off';
% xt = get(gca, 'XTick');
% set(gca, 'FontWeight', 'Bold')
%
% xlabel('Time (hours)','FontSize',14,'FontWeight','bold','Color','k')
% ylabel('Phosph. JAK2','FontSize',14,'FontWeight','bold','Color','k')
%
% % Save it
% saveas(f,strcat('figures/','pJAK2','.png'))
