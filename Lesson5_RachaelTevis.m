%Lecture 5
t = csvread('tempdata.csv');

%Read 2015 electricity demand data
data = csvread('hourly-day-ahead-bid-data-2015.csv',5,1);
vector = mat2vec(data);

%Read 2014 electricity demand data
bizarre_data = csvread('bizarre_data.csv')

%Pre-process Data
processed_data = pre_processor(bizarre_data);

candidates = find(processed_data > 130000);
index = candidates(find(candidates>7000));
day = floor(index/24);
hour = index - day*24;
answer = [day hour];

%histogram
figure;
histogram(processed_data,100); 
xlabel('Demand (MWh)','FontSize', 14)
ylabel('Frequency','FontSize', 14)
title('Pre-processed 2014 Data', 'FontSize',14)

%qqplot
figure; 
qqplot(processed_data); 
xlabel('Theoretical Normal Quantiles','FontSize',14)
ylabel('Empirical Data Normal Quantiles','FontSize',14)
title('QQ Plot of Pre-Processed Demand Data','FontSize',14)

%log transformation
transformed_data = log(processed_data); 

%histogram
figure; 
histogram(transformed_data,100); 
xlabel('log-Demand (MWh)','FontSize', 14)
ylabel('Frequency','FontSize', 14)
title('Log-Transformed 2014 Data', 'FontSize',14)


%qqplot
figure;
qqplot(transformed_data);
xlabel('Theoretical Normal Quantiles','FontSize',14)
ylabel('Empirical Data Normal Quantiles','FontSize',14)
title('QQ Plot of Log-Transformed Demand Data','FontSize',14)

%mean
mu = mean(transformed_data); 
dev = std(transformed_data); 

%number of standard deviations weird point is away from mean
number_stds = (transformed_data(index) - mu)/dev;



% #4 It is not reasonable to do a statistical outlier test based on
% standard deviations away from the mean demand for the entire year.
% Because the data set represents hourly demand bid data for the entire
% year of 2015, there will be different energy demand trends for different
% seasons of the year because energy demand is highly, if not entirerly a
% result of weather patterns. Therefore by comparing each point to the
% mean and STD of our enire data set, some outliers for different seasons
% may be kept or left out of the data unintentionally. We need to instead
% compare the values of each point to the mean and STD of a sample within
% the same season or time frame of the year to insure it follows these
% trends. 




%moving window assessment
num_hours = length(transformed_data);
window = 500;

%ouput
outliers = zeros(num_hours,1);

% for i = 251 to i = 8510
for i = window/2 + 1:num_hours-window/2

    % calculate the mean for every point in transformed data from (i-250)
    % to (i + 250) (a 501 point window)
    window_mean = mean(transformed_data,i - 250 :i+250);
    
    % calculate the std. deviation for every point in transformed data from
    % (i-250) to (i + 250) (a 501 point window)
    window_std = std(transformed_data,0, i - 250 :i+250);
    
    % test whether points 251:8510 in transformed data are outliers
    if transformed_data(i) >= window_mean + 3*window_std | transformed_data(i) <= window_mean - 3*window_std
        outliers(i) = 1;
    else
        outliers(i) = 0;
    end
    
end

find(outliers>0);

% #5 continued: The best way to determine if a point was an outlier was to progress through the entire data set 
%using a selection window that processed specific amounts of data at a time. Because energy demand is seasonally 
%based due to the changing weather and climate trends, looking at data points and comparing the characteristics of mean and
%std to similar values within a window allows us to more accurately determine which values are outliers for their particular 
%seasons. If there is an outlier in our data, we can either choose to fix it, or to ignore the point. If the outlier is 
%greater than 3-4 standard deviations away from the avg mean and std of the window selection, the point should be removed. For
%this example with over 8,000 data points, it is not entirerly necessary to remove the point because it most likely has little 
%influence on the entire mean and std for the entire data set, however, for data sets with a smaller sample size, outliers
%should be removed in order to have data that is more accurate and representative of the true trends. 



%Data Mining #1


peak = zeros(365,1);

for x = 1:365
   
   for y = transformed_data(1 +(x*24 - 24):  x *24);  
    
    peak(x) = max(y)
   end 
end 

peaky = csvwrite('peak.csv' peak);

% Data Mining # 2
t = csvread('tempdata.csv');

%Data Mining #3
scatter(peak, t);

% my code would not run in this format and continues to not recognize peak or t as vatiables, however, I was able to take the
% data from both peak and the tempdata and used excel to still create a
% plot and view the data shows that when the temperature is higher than
% average or lower than average, that peak energy demand for the day is
% higher. This makes sense as energy demand is almost entirerly dependent
% upon the weather. 






















