function [ melIdx2Frq ] = MelFreqs( nbanks,fs )
%MelFreqs Return the center frequencies
%   nbanks- Number of frequency banks
    % linear frequencies
    linFrq = 20:fs/2;
    % mel frequencies
    melFrq = log ( 1 + linFrq/700) *1127.01048;
    % equispaced mel indices
    melIdx = linspace(1,max(melFrq),nbanks+2);
    % From mel index to linear frequency
    melIdx2Frq = zeros (1,nbanks+2);
    % melIdx2Frq (p) = \Omega_p
    for i=1:nbanks+2
        [~, indx] = min(abs(melFrq - melIdx(i)));
        melIdx2Frq(i) = linFrq(indx);
    end
end

