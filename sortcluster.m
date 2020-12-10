n_clusters = 2;

%stacked_outputs(isnan(stacked_outputs)) = 0;
sorted_outputs = zeros(1000,1441,4);

%for output = 1 : 4
%	Z(:,:,output) = linkage((D(:,output))','ward');
%	C = cluster(Z(:,:,output),'maxclust',2);
%end

for output = 1 : 4
	%clusters(:,output) = kmeans(stacked_outputs(:,:,output),n_clusters);
	start = 1;
	for i = 1 : n_clusters
		cluster = outputs(T(:,:,output)==i,:,output);
		last = start + size(cluster,1) - 1;
		sorted_outputs(start:last,:,output) = cluster;
		start = last + 1;
	end
end


