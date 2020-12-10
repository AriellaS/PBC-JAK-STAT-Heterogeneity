load('data/results/outputs_rampedPRL_24hrs.mat');
load('data/results/distances_rampedPRL_24hrs.mat');

output_names = ["Nuclear to cytosolic pSTATA","Nuclear to cytosolic pSTATB","Total pSTATA to total STATA","Total pSTATB to total STATB"];

for output = 1 : 4
	Z(:,:,output) = linkage(D(:,:,output)),'centroid');
	dendrogram(Z(:,:,output)));
	title(output_names(output));
	set(gca,'fontsize',15);
	saveas(gcf,"figures/clusters/24hrs_rampedPRL/dendrogram_" + num2str(output) + ".png");
	for k = 2 : 10
		C = cluster(squeeze(Z(:,:,output)),'maxclust',k);
		silhouette(squeeze(outputs(output,1:1000,:)),C,squeeze(D(output,:,:)));
		title(output_names(output));
		set(gca,'fontsize',15);
		saveas(gcf,"figures/clusters/24hrs_rampedPRL/silhouette_" + num2str(output) + "_" + num2str(k) + ".png");
	end
end
