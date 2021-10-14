clear all;

response_labels = [{"Nuclear/cytosolic";"ratio pSTAT5A"},{"Nuclear/cytosolic";"ratio pSTAT5B"},{"Relative conc.";"pSTAT5A"},{"Relative conc.";"pSTAT5B"}];
initval_labels = ["RJ","SHP2","PPX","PPN"];
num_responses = length(response_labels);
num_initvals = length(initval_labels);

c = [0 0 0];

responses = importdata('../holly_results/lowest_error_responses.mat');
responses = responses(:,361,:);
free_initvals = importdata('../error_ranked_parameters/lowest_error_free_initvalues.mat');

figure(1)
for i = 1 : num_responses
	for j = 1 : num_initvals
		subplot(num_responses,num_initvals,num_initvals*(i-1)+j)
		scatter(free_initvals(:,j),responses(:,i),10,c,'filled','markerfacealpha',0.2);
		if (i==num_responses)
			xlabel({initval_labels(j);"initial concentration";" ";" "},'fontweight','bold','fontsize',11,'Rotation',0)
		end
		if (j==1)
			ylabel(response_labels(:,i),'fontweight','bold','fontsize',10)
		end
	end
end
set(gcf,'Position',[100 60 800 600])

