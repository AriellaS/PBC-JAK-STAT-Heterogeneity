thinned_initvals = importdata('../thinned_parameters/thinned_free_initvalues.mat');
error_ranked_initvals = importdata('../error_ranked_parameters/error_ranked_free_initvalues.mat');
lowest_error_initvals = importdata('../error_ranked_parameters/lowest_error_free_initvalues.mat');

initval_labels = {"RJ","SHP2","PPX","PPN"};
num_initvals = length(initval_labels);

figure(1)
for i = 1 : num_initvals
	subplot(2,4,i)
	histogram(thinned_initvals(:,i))
	title(initval_labels(i));
end
for i = 1 : num_initvals
	subplot(2,4,num_initvals + i)
	histogram(log10(thinned_initvals(:,i)))
	xlabel("Log10");
end
sgtitle("Initial value distributions using thinned parameters");

figure(2)
for i = 1 : num_initvals
	subplot(2,4,i)
	histogram(error_ranked_initvals(:,i))
	title(initval_labels(i));
end
for i = 1 : num_initvals
	subplot(2,4,num_initvals + i)
	histogram(log10(error_ranked_initvals(:,i)))
	xlabel("Log10");
end
sgtitle("Initial value distributions using error ranked parameters");

figure(3)
for i = 1 : num_initvals
	subplot(2,4,i)
	histogram(lowest_error_initvals(:,i))
	title(initval_labels(i));
end
for i = 1 : num_initvals
	subplot(2,4,num_initvals + i)
	histogram(log10(lowest_error_initvals(:,i)))
	xlabel("Log10");
end
sgtitle("Initial value distributions using lowest error parameters");



