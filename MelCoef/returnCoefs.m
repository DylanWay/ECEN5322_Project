function mfcc = returnCoefs(file,N,t)
    %Mel Coefficients
%     N = 512; %512 samples per frame
%     P = N/2; %N/2 overlap
    Nb = 40; %Bank number
    K = N/2+1;

    [samples,fs] = ReadAudio(file,t); %Only 30 seconds
    
    Omega_p = MelFreqs( Nb,fs );
    fbank = MelBanks ( K, fs, Omega_p );

    spec = Spectro( samples,N,fs ); %Get the spectrum
    mfcc = MelSpecCoef( fbank, spec); %Get the MFCC coefficients
end