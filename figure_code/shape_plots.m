clear all; clc; close all;

load("../holly_results/lowest_error_shape1.mat")
load("../holly_results/lowest_error_responses.mat");

predTime = [0:60:6*3600];

numtoplot = 100;
response_labels = {"Nuclear/cytosolic ratio pSTAT5A","Nuclear/cytosolic ratio pSTAT5B","Relative concentration pSTAT5A","Relative concentration pSTAT5B"};

for res = 1 : 4
	response = responses(:,:,res);
	shape1 = shape1_indicies(:,res);
	shape1_courses = response(shape1,:);
	shape2_courses = response(~shape1,:);

	figure(res);
	set(gcf,'Position',[100 100 1000 500])
	sgtitle("100 normalized time courses, response " + num2str(res));
	subplot(1,2,1);
	y = shape1_courses(1:numtoplot,:);
	plot(predTime/3600,y./max(y,[],2));
	ylabel(response_labels(res),'fontsize',16);
	xlabel("Time (hours)");
	title("Shape 1",'fontsize',16)
	axis('square')
	percent1 = sum(shape1)/1E4 * 100;
	annotation('textbox',[0.25 0.1 0 0],'String',num2str(percent1)+"%",'EdgeColor','none','color','#A2142F','fontsize',13)

	subplot(1,2,2);
	y = shape2_courses(1:numtoplot,:);
	plot(predTime/3600,y./max(y,[],2));
	xlabel("Time (hours)");
	title("Shape 2",'fontsize',16);
	axis('square')
	percent2 = sum(~shape1)/1E4 * 100;
	annotation('textbox',[.7 0.1 0 0],'String',num2str(percent2)+"%",'EdgeColor','none','color','#A2142F','fontsize',13)
end

