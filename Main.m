%This file is used to train the SOM
%The directory of the tracks
path = './ecen5322/Volumes/project/tracks/';

%Pull the truth file
fid = fopen('./ecen5322/Volumes/project/ground_truth.csv');
truth = textscan(fid,'%s%s','delimiter',',');
tracks = truth{1};
genres = truth{2};

%Mel Coefficients
N = 512; %512 samples per frame
P = N/2; %N/2 overlap
ntracks = size(tracks,1);
Nb = 40; %Bank number
K = N/2+1;

%Build an SOM
net = selforgmap([12 12]);

%Iterate through tracks
for i=1:1
    j = randi([1 ntracks]);
    
    [pathstr,name,ext] = fileparts(char(tracks(j)));
    
    [samples,fs] = audioread(strcat(path,name,'.wav'));
    
    Omega_p = MelFreqs( Nb,fs );
    fbank = MelBanks ( K, fs, Omega_p );

    spec = Spectro( samples,N,fs ); %Get the spectrum
    mfcc = MelSpecCoef( fbank, spec); %Get the MFCC coefficients
    
    imagesc(mfcc)
    title(genres{j})
    xlabel('Discretized Timesteps')
    ylabel('MFCC Coefficients')
    
    pause(1)
    
    %Let's try training an SOM
    net = train(net,mfcc);
    
%     plotsompos(net,mfcc);
    
    y = net(mfcc);
    
    classes = vec2ind(y);
    
    %Let's play with the Markov Chaining
%     [TRANS, EMIS] = hmmestimate(classes,
end