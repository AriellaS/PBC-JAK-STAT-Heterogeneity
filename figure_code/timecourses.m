clear all; clc; close all;

thinned_responses = importdata('../holly_results/thinned_responses.mat');
error_ranked_responses = importdata('../holly_results/error_ranked_responses.mat');
lowest_error_responses = importdata('../holly_results/lowest_error_responses.mat');

predTime = [0:60:6*3600];
response_labels = {"Nuclear/cytosolic ratio pSTAT5A","Nuclear/cytosolic ratio pSTAT5B","Relative concentration pSTAT5A","Relative concentration pSTAT5B"};

figure(1);
for i = 1 : length(response_labels)
	subplot(2,2,i);
	plot(predTime/3600,thinned_responses(1:100,:,i));
	title(response_labels(i));
	xlabel("Time (hours)");
end
sgtitle("100 time courses using thinned parameters");

figure(2);
rng(0);
rand_indicies = randi(1e4,100,1);
for i = 1 : length(response_labels)
	subplot(2,2,i);
	plot(predTime/3600,error_ranked_responses(rand_indicies,:,i));
	title(response_labels(i));
	xlabel("Time (hours)");
end
sgtitle("100 time courses using error ranked parameters");

figure(3);
for i = 1 : length(response_labels)
	subplot(2,2,i);
	plot(predTime/3600,lowest_error_responses(1:100,:,i));
	title(response_labels(i));
	xlabel("Time (hours)");
end
sgtitle("100 time courses using lowest error parameters");


