function bins = Laplacian(M,K,P)
    %Given an input connection matrix, find clusters associated with N
    %eigenvalues, and create a state map
    
    %First, let's condition the similarity matrix with P
    Mn = M;
    Mn = Mn./max(max(Mn));
    Mn(Mn < P) = 0;
    %Make sure its symmetric, create the weighted adjacency matrix
    W = triu(Mn) - diag(diag(Mn)) + triu(Mn)';

    %Form the normalized Laplacian matrix
    Dn = diag(sum(W,2).^(-1/2)); %Degree matrix
    
    %Compute Lsym
    L = eye(length(W))-Dn*W*Dn;
    
    %Now, with have the quantized similarity graph, let's find the K
    %eigenvalues
    [V,D] = eigs(L,K,'sm');
    
    %Normalize the vectors V
    Vn = normr(V);
    
    %Bin the items using Kmeans
    bins = kmeans(Vn,K,'Distance','cityblock');
    
    %This tells us how well they are clustered from the normalized
    %Laplacian
    figure
    [silh3,h] = silhouette(Vn,bins,'cityblock');
    h = gca;
    h.Children.EdgeColor = [.8 .8 1];
    xlabel 'Silhouette Value'
    ylabel 'Cluster'
end