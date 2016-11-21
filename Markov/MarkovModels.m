%Create the Markov Models
%The directory of the tracks
path = './ecen5322/Volumes/project/tracks/';

%Pull the truth file
fid = fopen('./ecen5322/Volumes/project/ground_truth.csv');
truth = textscan(fid,'%s%s','delimiter',',');
tracks = truth{1};
genres = truth{2};

%Get unique genres
gen = unique(genres);

t = 30; %Only need 30 sec
n = 64;

%The states space
C = zeros(n);

%Group by genres
for i = 1:length(gen)
    %Train each Markov Model
    [rn,cn]=find(strcmp(genres,gen(i)));
    
    songs = tracks(rn);
    disp(gen(i))
    for j = 1:length(songs)
        [pathstr,name,ext] = fileparts(char(songs(j)));
        file = strcat(path,name,'.wav');
        %Keep pulling the mfcc coefficients to train the Markov Model
        mfcc = returnCoefs(file,t);
        
        %SOM?
        %Here, we need to find a state space to derive the sequence
        y = net(mfcc);
        X = vec2ind(y);
%         X = StateClassify(mfcc);
        
        %Get the coefficients
        C = C + full(sparse(X(1:end - 1) , X(2 : end),1,n,n));
        disp(j)
    end
    
    disp('Transition Matrix')
    
    %Now, normalize the matrix
    sum_T = sum(C , 2);

    T = (C./sum_T(:,ones(1,size(C , 1))));
    T(isnan(T)) = 0;
    
    %Save the markov model
    save(char(strcat(gen(i),'_T.mat')),'T')
end
