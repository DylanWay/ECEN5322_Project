function M = KullbackAdjacency
    %Compute the Graph, using Kulbeck-Leibler
    %The directory of the tracks
    path = './ecen5322/Volumes/project/tracks/';

    %Pull the truth file
    fid = fopen('./ecen5322/Volumes/project/ground_truth.csv');
    truth = textscan(fid,'%s%s','delimiter',',');
    tracks = truth{1};
    genres = truth{2};

    t = 30; %Only need 30 sec
    %Number of tracks to compare
    ntracks = size(tracks,1);
    M = zeros(ntracks);
    
    mfcc = cell(ntracks,1);
    
%     Get all the MFCCs
    for i = 1:ntracks
        [~,name,~] = fileparts(char(tracks(i)));
        file = strcat(path,name,'.wav');
        mfcc{i} = returnCoefs(file,t);
    end
    
    display('Finished Computing MFCCs')
    % 
    for i = 1:ntracks
        for j = i:ntracks
            %Find the divergence
            M(i,j) = KulbeckLeibler(mfcc{i},mfcc{j});
        end
        display(i)
    end

    %Now, make it symmetric
    M = triu(M) - diag(diag(M)) +triu(M)';

    save('M.mat','M')
end