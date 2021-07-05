clear; clc; close all;

load('../holly_results/lowest_error_features.mat');
load('../holly_results/lowest_error_shape1.mat');

colors = ["#fa0006" "#15a43f" "#da570e" "#129fec" "#5c1a8e" "#fb009f"];
labels = {"Height of peak","Height of min","Time of peak","Time of min","Slope from peak to min","Slope from min to 6hrs"};
response_labels = {"N/C ratio pSTAT5A","N/C ratio pSTAT5B","Relative conc. pSTAT5A","Relative conc. pSTAT5B"};
ylabelspacing = "       ";

index = reshape(1:6, 3, 2).';

%% showing all four responses

% for res = 1 : 4
% 	xlabels =  {response_labels(res),"Time, minutes","Slope"};
% 	figure(res)
% 	for f = 1 : 6
% 		subplot(2,3,index(f));
% 		histogram(log10(features(shape1_indicies(:,res),f,res)),'facecolor',colors(f));
% 		title(labels(f))
% 		xlabel(xlabels(ceil(f/2)) + " (log10)");
% 	end
% 	sgtitle(response_labels(res))
% 	set(gcf,'Position',[100 100 1000 500])
% end

nbins = 35;

%% only showing responses 1 and 3
for i = 1 : 2
	res = (i-1)*2 + 1; % 1->1 2->3
	xlabels =  {response_labels(res),"Minutes","Slope"};
	for f = 1 : 6
		subplot(2,6,(i-1)*6+f);
		histogram(log10(features(shape1_indicies(:,res),f,res)),nbins,'facecolor',colors(f));
		title(labels(f))
		xlabel(xlabels(ceil(f/2)) + " (log10)");
		if f == 1
			ylabel(res + ylabelspacing, 'Rotation', 0,'fontweight','bold','fontsize',16);
		end
	end
	sgtitle("Time course features of responses 1 and 3")
	set(gcf,'Position',[100 100 1500 500])
end


