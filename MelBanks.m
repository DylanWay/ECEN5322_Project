function [ fbank ] = MelBanks ( K, fs, Omega_p )
%MELBANKS Return the triangle filterbanks fbank
%   Omega_p- Center frequencies
%   K- Length of hat filter
    %Initialize fbanks
    fbank = zeros(length(Omega_p)-2,K);
    
    %Iterate through the filter banks
    for i=1:(length(Omega_p)-2)
        %Scaling coefficient between k and Omega
        B = K/(fs/2);
        
        %Coefficient
        A = (2/(Omega_p(i+2)-Omega_p(i)));
            
        %Get the initial K bank
        fbank(i,:) = 1:K;
        %Compute the right side of the filter
        rBank = A.*(Omega_p(i+2)-fbank(i,:)./B)./(Omega_p(i+2)-Omega_p(i+1));
        %Mask out values less than 0
        rBank = (rBank > 0).*rBank;
        
        %Now compute the left side
        fbank(i,:) = A.*(fbank(i,:)./B-Omega_p(i))./(Omega_p(i+1)-Omega_p(i));
        %Mask out lower than 0
        fbank(i,:) = (fbank(i,:) > 0).*fbank(i,:);
        
        %Concatenate both sides appropriately
        fbank(i,round(Omega_p(i+1).*B):K) = rBank(round(Omega_p(i+1).*B):K);  
    end
end

