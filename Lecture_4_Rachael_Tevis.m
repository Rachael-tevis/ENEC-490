% 6 Monte Carlo resampling (randn)
num_years = 10;
months = 12;
dataMeans = zeros(12,1);
dataSTD = zeros(12,1);
for y = 1:months
    dataMeans(y) = mean(monthly(y,:));
    dataSTD(y) = std(monthly(y,:));
end
monte = randn(num_years*months,1);
for x = 1:num_years
    for y = 1:months
        monte(y + (x-1)*months) = monte(y + (x-1)*months)*dataSTD(y) + dataMeans(y);
    end
end
figure;
plot(monte)