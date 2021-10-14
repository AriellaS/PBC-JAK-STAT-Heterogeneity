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


%% Run with best fit (PRL stimulation)

% Set options
options = odeset('RelTol',1e-9,'AbsTol',1e-12,'NonNegative',[1:size(selected_initvals,2)]);

%% simulate the model

parfor n = 1 : num_samples
	disp(n);

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

	initvalues(2) = RJ;
	initvalues(5) = SHP2;
	initvalues(6) = PPX;
	initvalues(7) = PPN;

	[~, predConc] = ode15s(@core_file_struct8,predTime,initvalues,options,params);
	results(n,:,:) = predConc;
end


%% simulate base model, lowest error

% params = lowest_error_params;
% initvalues = lowest_error_initvals;
%
% [~, predConc] = ode15s(@core_file_struct8,predTime,initvalues,options,params);
% results(:,:) = predConc;

