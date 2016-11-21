function T = Train(X,n)
    T = full(sparse(X(1:end - 1) , X(2 : end),1,n,n));

    sum_T = sum(T , 2);

    T = (T./sum_T(:,ones(1,size(T , 1))));
    T(isnan(T)) = 0;
end