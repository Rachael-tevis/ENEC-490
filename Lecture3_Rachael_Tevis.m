%Lecture 3

[data text combined] = xlsread('RNGWHHDm.xls','Data 1');

%call annual profile function
d = annual_profile(data) ;
[months,years] = size(d);

%create new figure
figure; 
hold on;

%plot function within for loop
for i  = 1:years
    plot(d(:,i),'color',rand(1,3));
end

xlabel('Month','FontSize',14);
set(gca, 'XTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
set(gca,'XTick',1:1:12);
ylabel('Natural Gas Price ($/MMBtu)','FontSize',14);
legend('2008','2009','2010','2011','2012','2013','2014','2015','2016');

% Statistics #2: Call monthly_stats
ms = monthly_stats(data);

% Synthetic Random Sample for January
January = ms(1,1) + ms(1,2)*randn(1000,1);

%Synthetic Random Sample for April
April = ms(4,1) + ms(4,2)*randn(1000,1);



%April and January Histogram
figure
hold on;

edges = -5:0.5:15;
histogram(April,edges);
histogram(January,edges);

xlabel('Natural Gas Price ($/MMBtu)','FontSize',16);
ylabel('Frequency','FontSize',16);

legend('April','January');

%What is wierd about the Histograms for January and April: 
% Only the bar for January appears. When the January variable is commented
% out with %% marks, I can see that the April data for the histogram was in
% the same place as the January information. So from the random synthetic
% samples, I can conclude that the Natural Gas Price for each random sample
% has the same number of occurances. 
% This makes sense though because random numbers from a standard normal
%0-mean, 1-variance distribution.



