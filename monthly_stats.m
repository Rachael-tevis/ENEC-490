function [ r ] = monthly_stats(vector)

r = zeros(12,12)

for i = 1:12
      for j = 1:12
          
          m(j,i) = {[mean(vector(i-1)*12+j), std(vector(i-1)*12+j)]};
      end
end 

end

          