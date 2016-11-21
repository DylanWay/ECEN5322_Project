function KL = KulbeckLeibler(data1,data2)
    %We want to measure the Kulbeck Leibler distance using Gaussian distros
    %This will build the graph
    d = size(data1,1); %This is the number of rows
    
    %Get the variance of the inputs
    cov1 = cov(data1');
    cov2 = cov(data2');
    %Get the mean of the inputs
    m1 = mean(data1,2);
    m2 = mean(data2,2);
    
    %Compute the distance
    KL = 0.5*(log(norm(cov2)/norm(cov1))-d+trace(cov2^-1*cov1)+(m2-m1)'*(cov2^-1)*(m2-m1));
end