%% VISUALIZER
%This file is used to train the SOM
%The directory of the tracks
path = './ecen5322/Volumes/project/tracks/';

%Pull the truth file
fid = fopen('./ecen5322/Volumes/project/ground_truth.csv');
truth = textscan(fid,'%s%s','delimiter',',');
tracks = truth{1};
genres = truth{2};

%Mel Coefficients
N = 256; %Samples per frame
ntracks = size(tracks,1);

%Okay, let's try to "smooth" it out a bit
j = randi([1 ntracks]);
[pathstr,name,ext] = fileparts(char(tracks(j)));
file = strcat(path,name,'.wav');
coef = returnCoefs(file,N,15);

x = mean(coef(1:6,:),1);
y = mean(coef(4:9,:),1);
z = mean(coef(7:12,:),1);

%% Let's "watch" the song in 3D
figure
for i = 1:length(coef)
    plot3(x(i),y(i),z(i),'marker','o')
    hold on
    plot3(x(1:i),y(1:i),z(1:i))
    hold off
    title(genres{j})
    pause(0.1)
end