cluster=parallel.cluster.Local();
cluster.JobStorageLocation='/home1/ariellas/matlabJobStorage';
[a,b]=evalc('system(''nproc --all'')');
cluster.NumWorkers=str2num(a);

global progress
global n_samples

load('data/results/outputs_rampedPRL_24hrs.mat');
n_samples = 1000;
pool = parpool(cluster,15);

for output = 1 : 4
	progress = 1;
	disp(output)
	data = squeeze(outputs(output,1:n_samples,:));
	D = pdist(data, @(x,y) dtwdist(x,y,output));
	Z(output,:,:) = linkage(D);
end

save('data/results/linkages_rampedPRL_24hrs','Z');
delete(pool);

function d = dtwdist(x,y,output)
	global progress
	global n_samples
	progress = progress + 1;
	disp(num2str(output) + " " + num2str(progress/n_samples * 100))
	[m,n] = size(y);
	d = zeros(m,1);
	parfor j = 1 : m
		d(j) = dtw(x,y(j,:));
	end
end


