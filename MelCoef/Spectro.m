function [ S ] = Spectro( samples,N,fs )
%Spectro Decomposes sampled input into a spectrogram using a kaiser window
%of sign N with overlap N/2
%   samples is the input sequence
%   spectrogram is the resulting spectrogram matrix
    w = kaiser(N,2.5);
    %Now return the output
    [S,~,~] = spectrogram(samples,w,N/2,N,fs);
end

