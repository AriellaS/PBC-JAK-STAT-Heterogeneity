clear all;

output = 1;

load("data/results/timecourse_classification/characteristics_response" + output + ".mat");
load("data/results/timecourse_classification/initvalues_response" + output + ".mat");
free_initValues = free_initValues(:,1:4);

num_features = size(characteristics,2);
num_initvals = size(free_initValues,2);

features = ["Peak height","Peak time","Min height","Min time","Peak to min slope","Min to 6hr slope"];
initvals = ["RJ","SHP2","PPX","PPN"];

figure(1)
for i = 1 : num_features
	for j = 1 : i
		disp(num_features*(i-1)+j)
		subplot(num_features,num_features,num_features*(i-1)+j)
		scatter(characteristics(:,j),characteristics(:,i),10);
		if (i==num_features)
			xlabel(features(j))
		end
		if (j==1)
			ylabel(features(i))
		end
	end
end

sgtitle("Pairwise Comparisons of Response " + output + " Features")


figure(2)
for i = 1 : num_features
	for j = 1 : num_initvals
		disp(num_initvals*(i-1)+j)
		subplot(num_features,num_initvals,num_initvals*(i-1)+j)
		scatter(free_initValues(:,j),characteristics(:,i),10);
		if (i==num_features)
			xlabel(initvals(j))
		end
		if (j==1)
			ylabel(features(i))
		end
	end
end

sgtitle("Pairwise Comparisons of Response " + output + " Features and Initial Concentrations")
