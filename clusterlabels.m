load('data/results/distances_24hrs.mat');

for i = 1 : 4
	Z(:,:,i) = linkage(D(i,:),'ward');
	c = cluster(Z(:,:,i),2);
	c(c == 1) = i * 2 - 1;
	c(c == 2) = i * 2;
	C(:,i) = c;
end


