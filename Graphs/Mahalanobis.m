function d = Mahalanobis(x,data)
    %Returns the distance of point to distribution
    cov1 = cov(data');
    m = mean(data,2);

    d = sqrt((x-m)'*cov1^-1*(x-m));
end