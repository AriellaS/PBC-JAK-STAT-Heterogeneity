clear all; clc; close all;

lowest_error_responses = importdata('../holly_results/lowest_error_responses.mat');

response_labels = {"Nuclear/cytosolic ratio pSTAT5A","Nuclear/cytosolic ratio pSTAT5B","Relative concentration pSTAT5A","Relative concentration pSTAT5B"};

nbins = 50;
c = [0.5 0.5 0.5];

figure(1);
for i = 1 : 4
	subplot(2,2,i);
	response = log10(lowest_error_responses(:,end,:));
	histogram(response(:,i),nbins,'facecolor',c);
	xmin1 = min(response(:,i));
	xmax1 = max(response(:,i));
	if mod(i,2) == 0
		xmin2 = min(response(:,i-1));
		xmax2 = max(response(:,i-1));
	else
		xmin2 = min(response(:,i+1));
		xmax2 = max(response(:,i+1));
	end
	xmin = min(xmin1,xmin2);
	xmax = max(xmax1,xmax2);
	xlim([xmin-0.1 xmax+0.1])
	title(response_labels(i));
	if i > 2
		xlabel("Log_{10} (response)");
	end
	if mod(i,2) ~= 0
		ylabel("Number of cells")
	end
end
