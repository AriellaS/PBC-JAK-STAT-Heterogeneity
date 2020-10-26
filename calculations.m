%--- Get free param values from analyze_fits.m
ALL_params = importdata('free_params_struct8.mat');

%--- select param set with lowest error
 var = 1115;
selected_paramSet = ALL_params(var,:);
free_params1 = selected_paramSet(1,:);

totalSTAT = free_params1(25);
Vratio = 0.5;

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

total_statA = nuclear_statA*Vratio + cytosolic_statA;
total_statB = nuclear_statB*Vratio + cytosolic_statB;

totpA_ratio_totA = (nuclear_pStatA*Vratio + cytosolic_pStatA)./totalSTAT;
totpB_ratio_totB = (nuclear_pStatB*Vratio + cytosolic_pStatB)./totalSTAT;

outputs(1,:,:) = npA_ratio_cpA;
outputs(2,:,:) = npB_ratio_cpB;
outputs(3,:,:) = totpA_ratio_totA;
outputs(4,:,:) = totpB_ratio_totB;

outputs(isnan(outputs)) = 0;

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


