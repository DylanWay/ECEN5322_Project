function index = GraphIndex(dataset,sample,M,N)
    %Compute the index, using the eigenvalues magnitudes as bins
    n = length(dataset);
    %First, get number of zeros
    
    %Time to which bin the graph is in
    [Vn,Dn] = eig(H);
    
    %% Using N, get the state index
    [G,I] = sort(diag(Dn),'ascend');
    m = unique(G);
    G = G(G <= m(N)); %Only use bottom N
end