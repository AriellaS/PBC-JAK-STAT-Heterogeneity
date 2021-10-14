clear; clc; close all;

load('../holly_results/lowest_error_features.mat');
load('../holly_results/lowest_error_shape1.mat');

colors = ["#fa0006" "#15a43f" "#da570e" "#129fec" "#5c1a8e" "#fb009f"];
labels = {"Height of peak","Height of min","Time of peak","Time of min","Slope from peak to min","Slope from min to 6hrs"};
response_labels = {"N/C ratio","N/C ratio","Relative conc.","Relative conc."};
ylabelspacing = "       ";
y_labels = [{"Nuclear/cytosolic";"ratio pSTAT5A"},{"Nuclear/cytosolic";"ratio pSTAT5B"},{"Relative conc.";"pSTAT5A"},{"Relative conc.";"pSTAT5B"}];

index = reshape(1:6, 3, 2).';

%% showing all four responses

% for res = 1 : 4
% 	xlabels =  {response_labels(res),"Time, minutes","Slope"};
% 	figure(res)
% 	for f = 1 : 6
% 		subplot(2,3,index(f));
% 		histogram(log10(features(shape1_indicies,f,res)),'facecolor',colors(f));
% 		title(labels(f))
% 		xlabel(xlabels(ceil(f/2)) + " (log10)");
% 	end
% 	sgtitle(response_labels(res))
% 	set(gcf,'Position',[100 100 1000 500])
% end

nbins = 35;

%% only showing responses 1 and 3
figure(1)
for i = 1 : 2
	res = (i-1)*2 + 1; % 1->1 2->3
	xlabels =  {response_labels(res),"minutes","slope"};
	for f = 1 : 6
		subplot(2,6,(i-1)*6+f);
		histogram(log10(features(shape1_indicies,f,res)),nbins,'facecolor',colors(f));
		if i == 1
			title(f + ". " + labels(f),'fontsize',15)
		end
		xlabel("Log_{10} (" + xlabels(ceil(f/2)) + ")",'fontsize',13);
		if f == 1
			ylabel(y_labels(:,res),'fontweight','bold','fontsize',16);
		end
	end
	% sgtitle("Time course features",'fontsize',24)
	set(gcf,'Position',[100 100 1500 500])
end


%% only showing responses 2 and 4
%% figure S-2
figure(2)
for i = 1 : 2
	res = i*2; % 1->2 2->4
	xlabels =  {response_labels(res),"minutes","slope"};
	for f = 1 : 6
		subplot(2,6,(i-1)*6+f);
		histogram(log10(features(shape1_indicies,f,res)),nbins,'facecolor',colors(f));
		if i == 1
			title(f + ". " + labels(f),'fontsize',15)
		end
		xlabel("Log_{10} (" + xlabels(ceil(f/2)) + ")",'fontsize',13);
		if f == 1
			ylabel(y_labels(:,res),'fontweight','bold','fontsize',16);
		end
	end
	% sgtitle("Time course features",'fontsize',24)
	set(gcf,'Position',[100 100 1500 500])
end


