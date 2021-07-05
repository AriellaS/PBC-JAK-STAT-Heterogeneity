clear all; clc; close all;

thinned_responses = importdata('../holly_results/thinned_responses.mat');
error_ranked_responses = importdata('../holly_results/error_ranked_responses.mat');
lowest_error_responses = importdata('../holly_results/lowest_error_responses.mat');

response_labels = {"Nuclear/cytosolic ratio pSTAT5A","Nuclear/cytosolic ratio pSTAT5B","Relative concentration pSTAT5A","Relative concentration pSTAT5B"};

nbins = 50;
c = [0.5 0.5 0.5];

figure(1);
for i = 1 : 4
	subplot(2,2,i);
	histogram(log10(thinned_responses(:,end,i)),nbins,'facecolor',c);
	title(response_labels(i));
	xlabel("Log10");
end
sgtitle("Response at 6 hours using thinned parameters");

figure(2);
for i = 1 : 4
	subplot(2,2,i);
	histogram(log10(error_ranked_responses(:,end,i)),nbins,'facecolor',c);
	title(response_labels(i));
	xlabel("Log10");
end
sgtitle("Response at 6 hours using error ranked parameters");

figure(3);
for i = 1 : 4
	subplot(2,2,i);
	histogram(log10(lowest_error_responses(:,end,i)),nbins,'facecolor',c);
	title(response_labels(i));
	xlabel("Log10");
end
sgtitle("Response at 6 hours using lowest error parameters");
