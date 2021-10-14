clear all; clc; close all;

thinned_responses = importdata('../holly_results/thinned_responses.mat');
error_ranked_responses = importdata('../holly_results/error_ranked_responses.mat');
lowest_error_responses = importdata('../holly_results/lowest_error_responses.mat');

predTime = [0:60:6*3600];
response_labels = {"Nuclear/cytosolic ratio pSTAT5A","Nuclear/cytosolic ratio pSTAT5B","Relative concentration pSTAT5A","Relative concentration pSTAT5B"};

% figure(1);
% for i = 1 : length(response_labels)
% 	subplot(2,2,i);
% 	y = thinned_responses(:,:,i);
% 	plot(predTime/3600,y./max(y,[],2),'color',[0 0 0 0.01]);
% 	title(response_labels(i));
% 	xlabel("Time (hours)");
% end
% sgtitle("100 normalized time courses using thinned parameters");
%
% figure(2);
% rng(0);
% rand_indicies = randi(1e4,100,1);
% for i = 1 : length(response_labels)
% 	subplot(2,2,i);
% 	y = error_ranked_responses(:,:,i);
% 	plot(predTime/3600,y./max(y,[],2),'color',[0 0 0 0.01]);
% 	title(response_labels(i));
% 	xlabel("Time (hours)");
% end
% sgtitle("100 normalized time courses using error ranked parameters");

figure(3);
for i = 1 : length(response_labels)
	subplot(2,2,i);
	y = lowest_error_responses(:,:,i);
	plot(predTime/3600,y./max(y,[],2),'color',[0 0 0 0.01]);
	title(response_labels(i));
	if i > 2
		xlabel("Time (hours)");
	end
end
% sgtitle("Normalized time courses using lowest error parameters");


