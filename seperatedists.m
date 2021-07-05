
load("data/samples/free_initValues.mat");
free_initValues = free_initValues(:,1:4);
num_initvals = size(free_initValues,2);
initvals = ["RJ","SHP2","PPX","PPN"];
colors = ["#fa0006","#da570e","#15a43f","#129fec","#5c1a8e","#fb009f"];

%% response 1, feature 2

feature = 2;
num_bins = 3;

bin1 = response1_shape1(log10(characteristics_response1(:,feature)) > 1.2 & log10(characteristics_response1(:,feature)) < 1.5);
bin2 = response1_shape1(log10(characteristics_response1(:,feature)) > 1.5 & log10(characteristics_response1(:,feature)) < 1.65);
bin3 = response1_shape1(log10(characteristics_response1(:,feature)) > 1.65);

figure(1)
for i = 1 : num_initvals
	subplot(num_initvals,num_bins,1+num_bins*(i-1));
	histogram(free_initValues(bin1,i),25,'facecolor',colors(feature));
	ylabel(initvals(i));
	if (i == num_initvals)
		xlabel("1.2 < log10(time of peak) < 1.5");
	end

	subplot(num_initvals,num_bins,2+num_bins*(i-1));
	histogram(free_initValues(bin2,i),25,'facecolor',colors(feature));
	if (i == num_initvals)
		xlabel("1.5 < log10(time of peak) < 1.65");
	end

	subplot(num_initvals,num_bins,3+num_bins*(i-1));
	histogram(free_initValues(bin3,i),25,'facecolor',colors(feature));
	if (i == num_initvals)
		xlabel("log10(time of peak) > 1.65")
	end
end

sgtitle("Initial value distributions split by response 1 time of peak bins")
set(gcf,'color','w');


%% response 3, feature 1

feature = 1;
num_bins = 2;

bin1 = response3_shape1(characteristics_response3(:,feature) < 0.55);
bin2 = response3_shape1(characteristics_response3(:,feature) > 0.55);

figure(2)
for i = 1 : num_initvals
	subplot(num_initvals,num_bins,1+num_bins*(i-1));
	histogram(free_initValues(bin1,i),25,'facecolor',colors(feature));
	ylabel(initvals(i));
	if (i == num_initvals)
		xlabel("height of peak < 0.55");
	end

	subplot(num_initvals,num_bins,2+num_bins*(i-1));
	histogram(free_initValues(bin2,i),25,'facecolor',colors(feature));
	if (i == num_initvals)
		xlabel("height of peak > 0.55");
	end
end

sgtitle("Initial value distributions split by response 3 height of peak bins")
set(gcf,'color','w');


%% response 3, feature 5

feature = 5;
num_bins = 2;

bin1 = response3_shape1(characteristics_response3(:,feature) < 1.2E-3);
bin2 = response3_shape1(characteristics_response3(:,feature) > 1.2E-3);

figure(3)
for i = 1 : num_initvals
	subplot(num_initvals,num_bins,1+num_bins*(i-1));
	histogram(free_initValues(bin1,i),25,'facecolor',colors(feature));
	ylabel(initvals(i));
	if (i == num_initvals)
		xlabel("slope < 1.2E-3");
	end

	subplot(num_initvals,num_bins,2+num_bins*(i-1));
	histogram(free_initValues(bin2,i),25,'facecolor',colors(feature));
	if (i == num_initvals)
		xlabel("slope > 1.2E-3");
	end
end

sgtitle("Initial value distributions split by response 3 slope from peak to min bins")
set(gcf,'color','w');


%% response 3, feature 6

feature = 6;
num_bins = 2;

bin1 = response3_shape1(characteristics_response3(:,feature) < 1.3E-3);
bin2 = response3_shape1(characteristics_response3(:,feature) > 1.3E-3);

figure(4)
for i = 1 : num_initvals
	subplot(num_initvals,num_bins,1+num_bins*(i-1));
	histogram(free_initValues(bin1,i),25,'facecolor',colors(feature));
	ylabel(initvals(i));
	if (i == num_initvals)
		xlabel("slope < 1.3E-3");
	end

	subplot(num_initvals,num_bins,2+num_bins*(i-1));
	histogram(free_initValues(bin2,i),25,'facecolor',colors(feature));
	if (i == num_initvals)
		xlabel("slope > 1.3E-3");
	end
end

sgtitle("Initial value distributions split by response 3 slope from min to 6hr bins")
set(gcf,'color','w');


