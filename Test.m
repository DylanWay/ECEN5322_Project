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
net = selforgmap([8 8]);

%Iterate through tracks
for i=1:ntracks
    j = randi([1 ntracks]);
    [pathstr,name,ext] = fileparts(char(tracks(j)));
    
    file = strcat(path,name,'.wav');
    returnCoefs(file,30);
    
    %Let's try training an SOM
    net = train(net,mfcc);
        
    y = net(mfcc);
    classes = vec2ind(y);
    
    %Play with a Markov Model
    T = Train(classes,size(y,1));
end