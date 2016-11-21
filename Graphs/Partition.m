function w = Partition(A)
    [V,~] = eigs(A,2);
    %Choose second eigenvector
    V = V(:,2);
    
    w = zeros(length(V),1);
    
    %Iterate and assign to communities
    for i=1:length(V)
        if V(i) > 0
            w(i) = 1;
        else
            w(i) = -1;
        end
    end
end