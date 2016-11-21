function o = Overlap(wi,wj)
    %Compute both raw overlaps
    
    sigma1 = sum(abs(wi+wj)/2);
    sigma2 = sum(abs(wi+-wj)/2);
    
    rawoverlap = max([sigma1,sigma2]);
    
    o = 2/length(wi)*rawoverlap-1;
end