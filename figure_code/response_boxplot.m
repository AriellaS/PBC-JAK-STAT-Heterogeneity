clear; clc; close all;

varied_initval_responses = load('../holly_results/varied_initval_responses.mat').responses;
base_responses = load('../holly_results/lowest_error_responses.mat').responses;


matrix = [0 0 1 1;
	0 0 1 1;
	0 0 0 1;
	0 0 0 1;
	];
% represents which initvals have vip>1 for each response

initval_labels = ["RJ","SHP2","PPX","PPN"];
response_labels = {"Nuclear/cytosolic ratio pSTAT5A","Nuclear/cytosolic ratio pSTAT5B","Relative concentration pSTAT5A","Relative concentration pSTAT5B"};
factor_labels = ["0.1","1","10"];

%% Show varying significant initvals

% for res = 1 : 4
% 	figure(res)
% 	count = 0;
% 	for initval = 1 : 4
% 		if matrix(res,initval) == 1
% 			count = count + 1;
% 			subplot(1,sum(matrix(res,:)),count);
% 			boxplot(log10(squeeze(responses(:,end,:,initval,res))),factor_labels);
% 			xlabel(initval_labels(initval) + " proportion of baseline")
% 			ylabel(response_labels(res) + " (log10)");
% 			title("Varying " + initval_labels(initval));
% 		end
% 	end
% 	set(gcf,'Position',[100 100 500*count 500])
% 	sgtitle({["Response " + num2str(res) + " at 6 hours"];[""]})
% end

%% Show varying all initvals

for res = 1 : 4
	% figure(res)
	for initval = 1 : 4
		response(:,1) = varied_initval_responses(:,end,1,initval,res);
		response(:,2) = base_responses(:,end,res);
		response(:,3) = varied_initval_responses(:,end,2,initval,res);

		subplot(4,4,(res-1)*4+initval);
		boxplot(log10(response),factor_labels);
		if res == 4
			xlabel(initval_labels(initval) + " proportion of baseline")
		end
		if initval == 1
			ylabel("Response " + num2str(res) + " (log10)");
		end
		if res == 1
			title("Varying " + initval_labels(initval));
		end
	end
	set(gcf,'Position',[100 100 1000 1000])
	% sgtitle({["Responses " + num2str(res) + " at 6 hours"];[""]})
end
