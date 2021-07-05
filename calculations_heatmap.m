clear; clc; close all;

%--- Get free param values
error_ranked_params = importdata('error_ranked_parameters/error_ranked_parameters.mat');
lowest_error_params = error_ranked_params(1,:);

%--- select paramset
selected_paramset = lowest_error_params;
% results = importdata('holly_results/heatmap/lowest_error_PredConc_prl_ppx.mat');
results = importdata('holly_results/heatmap/lowest_error_PredConc_prl_ppn.mat');

totalSTAT = selected_paramset(:,54);
Vratio = selected_paramset(:,51);

% Calculated quantities

cytosolic_pStatA = results(:,:,:,:,13) + 2.*results(:,:,:,:,15) + results(:,:,:,:,16) + results(:,:,:,:,19) + 2*results(:,:,:,:,21) + results(:,:,:,:,23) + results(:,:,:,:,24) + results(:,:,:,:,27);
cytosolic_pStatB = results(:,:,:,:,14) + 2.*results(:,:,:,:,17) + results(:,:,:,:,16) + results(:,:,:,:,20) + 2*results(:,:,:,:,22) + results(:,:,:,:,23) + results(:,:,:,:,25) + results(:,:,:,:,26);

nuclear_pStatA = 2*results(:,:,:,:,28) + results(:,:,:,:,29) + results(:,:,:,:,31) + results(:,:,:,:,33) + 2*results(:,:,:,:,37) + results(:,:,:,:,38) + results(:,:,:,:,40) + results(:,:,:,:,43);
nuclear_pStatB = 2*results(:,:,:,:,30) + results(:,:,:,:,29) + results(:,:,:,:,32) + results(:,:,:,:,34) + 2*results(:,:,:,:,39) + results(:,:,:,:,38) + results(:,:,:,:,41) + results(:,:,:,:,42);

npA_ratio_cpA = nuclear_pStatA./cytosolic_pStatA;
npB_ratio_cpB = nuclear_pStatB./cytosolic_pStatB;

total_pStatA = results(:,:,:,:,13) +2.*results(:,:,:,:,15) + results(:,:,:,:,16) + results(:,:,:,:,19) + 2*results(:,:,:,:,21) + results(:,:,:,:,23) + results(:,:,:,:,24) + results(:,:,:,:,27) + 2*results(:,:,:,:,28) + results(:,:,:,:,29) + results(:,:,:,:,31) + results(:,:,:,:,33) + 2*results(:,:,:,:,37) + results(:,:,:,:,38) + results(:,:,:,:,40) + results(:,:,:,:,43);
total_pStatB = results(:,:,:,:,14) +2.*results(:,:,:,:,17) + results(:,:,:,:,16) + results(:,:,:,:,20) + 2*results(:,:,:,:,22) + results(:,:,:,:,23) + results(:,:,:,:,25) + results(:,:,:,:,26) + 2*results(:,:,:,:,30) + results(:,:,:,:,29) + results(:,:,:,:,32) + results(:,:,:,:,34) + 2*results(:,:,:,:,39) + results(:,:,:,:,38) + results(:,:,:,:,41) + results(:,:,:,:,42);

cytosolic_statA = results(:,:,:,:,3) + results(:,:,:,:,11) + results(:,:,:,:,13) + 2*results(:,:,:,:,15) + results(:,:,:,:,16) + results(:,:,:,:,19) + 2*results(:,:,:,:,21) + results(:,:,:,:,23) + 2*results(:,:,:,:,24) + results(:,:,:,:,26) + results(:,:,:,:,27) + results(:,:,:,:,48);
cytosolic_statB = results(:,:,:,:,4) + results(:,:,:,:,12) + results(:,:,:,:,14) + 2*results(:,:,:,:,17) + results(:,:,:,:,16) + results(:,:,:,:,20) + 2*results(:,:,:,:,22) + results(:,:,:,:,23) + 2*results(:,:,:,:,25) + results(:,:,:,:,26) + results(:,:,:,:,27) + results(:,:,:,:,49);

nuclear_statA = 2*results(:,:,:,:,28) + results(:,:,:,:,29) + results(:,:,:,:,31) + results(:,:,:,:,33) + results(:,:,:,:,35) + 2*results(:,:,:,:,37) + results(:,:,:,:,38) + 2*results(:,:,:,:,40) + results(:,:,:,:,42) + results(:,:,:,:,43);
nuclear_statB = 2*results(:,:,:,:,30) + results(:,:,:,:,29) + results(:,:,:,:,32) + results(:,:,:,:,34) + results(:,:,:,:,36) + 2*results(:,:,:,:,39) + results(:,:,:,:,38) + 2*results(:,:,:,:,41) + results(:,:,:,:,42) + results(:,:,:,:,43);

total_statA = nuclear_statA*Vratio + cytosolic_statA;
total_statB = nuclear_statB*Vratio + cytosolic_statB;

totpA_ratio_totA = (nuclear_pStatA*Vratio + cytosolic_pStatA)./totalSTAT;
totpB_ratio_totB = (nuclear_pStatB*Vratio + cytosolic_pStatB)./totalSTAT;

responses(:,:,:,:,1) = npA_ratio_cpA;
responses(:,:,:,:,2) = npB_ratio_cpB;
responses(:,:,:,:,3) = totpA_ratio_totA;
responses(:,:,:,:,4) = totpB_ratio_totB;

responses(isnan(responses)) = 0;


