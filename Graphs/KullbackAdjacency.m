function [M,mfcc,genres] = KullbackAdjacency ( path )
    %Compute the Graph, using Kullback-Leibler
    %music_path = strcat(path, 'tracks/');
    music_path = strcat(path, 'tracks\');
    truth_path = strcat(path, 'ground_truth.csv');

    %Pull the truth file
    fid = fopen(truth_path);
    truth = textscan(fid,'%s%s','delimiter',',');
    tracks = truth{1};
    genres = truth{2};
    save('genres.mat','genres')

    t = 30; %Only need 30 sec
    %Number of tracks to compare
    ntracks = size(tracks,1);
    M = zeros(ntracks);
    N = 512;
    
    mfcc = cell(ntracks,1);
    
%     Get all the MFCCs
    for i = 1:ntracks
        [~,name,~] = fileparts(char(tracks(i)));
        file = strcat(music_path,name,'.wav');
        mfcc{i} = returnCoefs(file,N,t);
    end
    
    display('Finished Computing MFCCs')
    for i = 1:ntracks
        for j = 1:ntracks
            %Find the divergence
            M(i,j) = KulbeckLeibler(mfcc{i},mfcc{j});
        end
        display(i)
    end

    %Now, make it symmetric
    %Not sure we can do this
    %M_asym = M;
    M = M + M';

    save('M.mat','M')
end