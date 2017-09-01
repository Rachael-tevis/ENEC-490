function [ m ] = monthly_stats(vector)

m = zeros(12,2)

for i = 1:12
      
          
          m(i,1) = mean(vector(i,:));
          m(i,2) = std(vector(i,:));

end
end 


          
