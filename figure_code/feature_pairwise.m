clear; clc; close all;

features = importdata('../holly_results/lowest_error_features.mat');
shape1_indicies = importdata('../holly_results/lowest_error_shape1.mat');
free_initvals = importdata('../error_ranked_parameters/lowest_error_free_initvalues.mat');

initval_labels = ["RJ","SHP2","PPX","PPN"];
ylabelspacing = "              ";
colors = ["#fa0006" "#15a43f" "#da570e" "#129fec" "#5c1a8e" "#fb009f"];
num_features = 6;
num_initvals = length(initval_labels);
response_labels = ["Ratio A","Ratio B","Relative A","Relative B"];

for res = 1 : 4
	figure(res)
	shape1_index = shape1_indicies(:,res);
	feature = features(shape1_index,:,res);
	initval = free_initvals(shape1_index,:);
	for i = 1 : num_features
		for j = 1 : num_initvals
			subplot(num_features,num_initvals,num_initvals*(i-1)+j)
			scatter(initval(:,j),feature(:,i),10,'markerfacecolor',colors(i),'markeredgecolor','none','markerfacealpha',0.2);
			if (i==num_features)
				xlabel({initval_labels(j);"initial concentration";" ";" "},'fontweight','bold','fontsize',14,'Rotation',0)
			end
			if (j==1)
				ylabel({response_labels(res)+ylabelspacing;"feature"+ylabelspacing;num2str(i)+ylabelspacing},'fontweight','bold','fontsize',14,'Rotation',0);
			end
		end
	end
	% sgtitle("Pairwise comparisons of response " + num2str(res) + " time course features and initial values")
	set(gcf,'Position',[100 100 1000 1000])
end



