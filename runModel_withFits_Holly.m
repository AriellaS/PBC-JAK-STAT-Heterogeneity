% Ariella Simoni
% May 25th, 2021

clear all
close all
type = 'weighted';

Data_time = importdata('tspan.mat');

%--- Model prediction timepoints
predTime = [0:60:6*3600];

%--- Thinned
thinned_params = importdata('thinned_parameters/thinned_parameters.mat');
thinned_initvals = importdata('thinned_parameters/thinned_initvalues.mat');
thinned_free_initvals = importdata('thinned_parameters/thinned_free_initvalues.mat');

%--- Error ranked
error_ranked_params = importdata('error_ranked_parameters/error_ranked_parameters.mat');
error_ranked_initvals = importdata('error_ranked_parameters/error_ranked_initval.mat');
error_ranked_free_initvals = importdata('error_ranked_parameters/error_ranked_free_initvalues.mat');

%--- Lowest error
lowest_error_params = error_ranked_params(1,:);
lowest_error_initvals = error_ranked_initvals(1,:);
lowest_error_free_initvals = importdata('error_ranked_parameters/lowest_error_free_initvalues.mat');

%--- select paramset and initvals
selected_paramset = lowest_error_params;
selected_initvals = lowest_error_initvals;
selected_free_initvals = lowest_error_free_initvals;

num_samples = length(selected_free_initvals);
% num_samples = 5;


%% Run with best fit (PRL stimulation)

% Set options
options = odeset('RelTol',1e-9,'AbsTol',1e-12,'NonNegative',[1:size(selected_initvals,2)]);

%% simulate the model
%
% parfor n = 1 : num_samples
% 	disp(n);
%
% 	if size(selected_paramset,1) > 1
% 		params = selected_paramset(n,:);
% 		initvalues = selected_initvals(n,:);
% 	else
% 		params = selected_paramset;
% 		initvalues = selected_initvals;
% 	end
%
% 	RJ = selected_free_initvals(n,1);
% 	SHP2 = selected_free_initvals(n,2);
% 	PPX = selected_free_initvals(n,3);
% 	PPN = selected_free_initvals(n,4);
%
% 	initvalues(2) = RJ;
% 	initvalues(5) = SHP2;
% 	initvalues(6) = PPX;
% 	initvalues(7) = PPN;
%
% 	[~, predConc] = ode15s(@core_file_struct8,predTime,initvalues,options,params);
% 	results(n,:,:) = predConc;
% end

%% simulate with ramping PRL

% prl_vals = [50, 100, 200, 300];
% prl_vals = [200, 0, 0, 0];
%
% for sim = 1 : length(prl_vals)
% 	disp(sim);
% 	parfor n = 1 : num_samples
% 		if (sim == 1)
% 			selected_initvalues = initvalues;
% 			selected_initvalues(1,1) = 0;
% 			selected_initvalues(2,1) = free_initValues(n,1);
% 			selected_initvalues(5,1) = free_initValues(n,2);
% 			selected_initvalues(6,1) = free_initValues(n,3);
% 			selected_initvalues(7,1) = free_initValues(n,4);
% 		else
% num_samples = 5;
% 			selected_initvalues = initvalues(n,:)';
% 		end
% 		selected_initvalues(1,1) = selected_initvalues(1,1) + prl_vals(sim) / 22;
% 		[~, predConc] = ode15s(@core_file_struct8,predTime,selected_initvalues,options,params);
% 		segmented_results(sim,n,:,:) = predConc;
% 	end
% 	initvalues = squeeze(segmented_results(sim,:,end,:));
% end
%
% results = zeros(num_samples,1441,56);
% results(:,1:361,:) = segmented_results(1,:,:,:);
% results(:,361:721,:) = segmented_results(2,:,:,:);
% results(:,721:1081,:) = segmented_results(3,:,:,:);
% results(:,1081:1441,:) = segmented_results(4,:,:,:);
%

%% simulate with varying PRL and another initval

% factors = [0.1, 1, 10];
%
% for i = 1 : length(factors)
% 	for j = 1 : length(factors)
% 		parfor n = 1 : num_samples
% 			if size(selected_paramset,1) > 1
% 				params = selected_paramset(n,:);
% 				initvalues = selected_initvals(n,:);
% 			else
% 				params = selected_paramset;
% 				initvalues = selected_initvals;
% 			end
%
% 			RJ = selected_free_initvals(n,1);
% 			SHP2 = selected_free_initvals(n,2);
% 			PPX = selected_free_initvals(n,3);
% 			PPN = selected_free_initvals(n,4);
%
% 			initvalues(1) = initvalues(1) * factors(i);
% 			PPX = PPX * factors(j);
% 			% PPN = PPN * factors(j)
%
% 			initvalues(2) = RJ;
% 			initvalues(5) = SHP2;
% 			initvalues(6) = PPX;
% 			initvalues(7) = PPN;
%
% 			[~, predConc] = ode15s(@core_file_struct8,predTime,initvalues,options,params);
% 			results(i,j,n,:,:) = predConc;
% 		end
% 	end
% end

%% simulate with varying all initvals separately

factors = [0.1, 1, 10];

for i = 1 : 4 % iterate thru initvals
	disp(i)
	for j = 1 : length(factors)
		parfor n = 1 : num_samples
			if size(selected_paramset,1) > 1
				params = selected_paramset(n,:);
				initvalues = selected_initvals(n,:);
			else
				params = selected_paramset;
				initvalues = selected_initvals;
			end

			RJ = selected_free_initvals(n,1);
			SHP2 = selected_free_initvals(n,2);
			PPX = selected_free_initvals(n,3);
			PPN = selected_free_initvals(n,4);

			free_initvals = [RJ SHP2 PPX PPN];

			free_initvals(i) = free_initvals(i) * factors(j);

			initvalues(2) = free_initvals(1);
			initvalues(5) = free_initvals(2);
			initvalues(6) = free_initvals(3);
			initvalues(7) = free_initvals(4);

			totalSTAT = params(54);
			Vratio = params(51);

			[~, predConc] = ode15s(@core_file_struct8,predTime,initvalues,options,params);
			response = calculations_boxplot(predConc,totalSTAT,Vratio);

			responses(n,:,j,i,:) = response;
		end
	end
end


%% simulate base model, lowest error

% params = lowest_error_params;
% initvalues = lowest_error_initvals;
%
% [~, predConc] = ode15s(@core_file_struct8,predTime,initvalues,options,params);
% results(:,:) = predConc;

