clear; clc; close all;

%--- Get fitted init values
% thinned_initvals = importdata('thinned_parameters/thinned_initvalues.mat');
error_ranked_initvals = importdata('error_ranked_parameters/error_ranked_initval.mat');
lowest_error_initvals = error_ranked_initvals(1,:);

selected_initvals = lowest_error_initvals;

indicies = [2,5,6,7];
num_samples = 1e4;
fold = 10;

%--- sample under a log-uniform distribution 10 fold above and below
x = selected_initvals(:,indicies);
A = log10(x ./ fold);
B = log10(x .* fold);
z = rand(num_samples,4);
samples = 10.^(A + (B-A).*z);

save('error_ranked_parameters/lowest_error_free_initvalues.mat','samples');

