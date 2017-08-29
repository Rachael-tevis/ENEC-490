Prices=csvread('EER.csv',3,1); 

for x= 1:30
    y = (x*12)-12;
    
    % add an extra year onto AVERAGE each iteration
    AVERAGE(x) = (sum(Prices((8 + y):(19 + y))))/12
       
end

% put this outside the loop -- I also took the 'transpose' of AVERAGE using the ', to make a column vector
csvwrite('monthly_average_price.csv',AVERAGE') 
    


