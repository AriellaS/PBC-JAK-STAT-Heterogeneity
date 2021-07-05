clear; clc; close all;

load('../holly_results/boxplot/varied_initval_features.mat')
load('../holly_results/boxplot/varied_initval_shape1.mat')
figpath = "../holly_figures/feature_boxplot/";

% represents which initvals have vip>1 for each feature
res1matrix = [0 0 1 1;
	0 0 1 1;
	1 0 0 1;
	1 0 0 1;
	1 0 0 1;
	0 0 0 1;
	];

res2matrix = [0 0 1 1;
	0 0 1 1;
	1 0 0 1;
	0 0 0 1;
	1 0 0 1;
	0 0 0 1;
	];

res3matrix = [1 0 0 0;
	0 1 0 1;
	1 0 0 0;
	1 0 0 0;
	1 0 0 0;
	0 0 0 1;
	];

res4matrix = [1 0 0 1;
	0 0 0 1;
	1 0 0 1;
	1 0 0 0;
	0 0 0 1;
	];

matrix(1,:,:) = res1matrix;
matrix(2,:,:) = res2matrix;
matrix(3,:,:) = res3matrix;
matrix(4,:,:) = res4matrix;

sample_size = 1E3;

initval_labels = ["RJ","SHP2","PPX","PPN"];
% response_labels = {"Nuclear/cytosolic ratio pSTAT5A","Nuclear/cytosolic ratio pSTAT5B","Relative concentration pSTAT5A","Relative concentration pSTAT5B"};
feature_labels = {"Height of peak","Height of min","Time of peak","Time of min","Slope from peak to min","Slope from min to 6hrs"};
factor_labels = {"0.1","1","10"};

for res = 1 : 4
	for feature = 1 : 6
		count = 0;
		fig = figure((res-1) * 6 + feature);
		for initval = 1 : 4
			shape1_index = shape1_indicies(:,:,initval,res);

			if matrix(res,feature,initval) == 1

				newmatrix = NaN(sample_size,3);

				for factor = 1 : 3
					fixed_features = features(shape1_index(:,factor),feature,factor,initval,res);
					fixed_features(end:sample_size) = NaN;
					newmatrix(:,factor) = fixed_features;
				end

				count = count + 1;
				subplot(1,sum(matrix(res,feature,:)),count);
				boxplot(log10(squeeze(newmatrix)),factor_labels);
				xlabel(initval_labels(initval) + " proportion of baseline")
				ylabel(feature_labels(feature) + " (log10)");
				title("Varying " + initval_labels(initval));
			end
		end
		sgtitle({["Response " + num2str(res) + ", feature " + num2str(feature)];[""]})
		set(gcf,'Position',[100 100 500*count 500])
		saveas(fig,figpath + num2str(res) + "/" +  num2str(res) + "_" + num2str(feature) + ".png");
	end
end

