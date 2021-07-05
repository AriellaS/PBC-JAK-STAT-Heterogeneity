clear; clc; close all;

load('../holly_results/boxplot/varied_initval_responses.mat')

matrix = [0 0 1 1;
	0 0 1 1;
	0 0 0 1;
	0 0 0 1;
	];
% represents which initvals have vip>1 for each response

initval_labels = ["RJ","SHP2","PPX","PPN"];
response_labels = {"Nuclear/cytosolic ratio pSTAT5A","Nuclear/cytosolic ratio pSTAT5B","Relative concentration pSTAT5A","Relative concentration pSTAT5B"};
factor_labels = ["0.1","1","10"];

for res = 1 : 4
	figure(res)
	count = 0;
	for initval = 1 : 4
		if matrix(res,initval) == 1
			count = count + 1;
			subplot(1,sum(matrix(res,:)),count);
			boxplot(log10(squeeze(responses(:,end,:,initval,res))),factor_labels);
			xlabel(initval_labels(initval) + " proportion of baseline")
			ylabel(response_labels(res) + " (log10)");
			title("Varying " + initval_labels(initval));
		end
	end
	set(gcf,'Position',[100 100 500*count 500])
	sgtitle({["Response " + num2str(res) + " at 6 hours"];[""]})
end
