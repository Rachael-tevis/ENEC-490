Prices=csvread('EER.csv',3,1); 

size(Prices);

sum(Prices(8:19))

for x= 1:30
    y = (x*12)-12;
    
    AVERAGE = (sum(Prices((8 + y):(19 + y))))/12
    
    csvwrite('monthly_average_price.csv',AVERAGE)
    
end

  
    


