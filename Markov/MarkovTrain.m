function [ T ] = MarkovTrain( T, Tmin, set, genres, mfcc, states, Gauss, current_genre )
    % T transition matrix to train
    % set contains indices of songs used for training set
    % genres contains truth data regarding song set
    % states contains the state information from Laplacian regarding foreach song?
    % Gauss contains the mean and covariance information for each song
    % mfcc contains the MFCCs for each song
    g = {'classical','electronic','jazz_blues','metal_punk','rock_pop','world'};
    n = max(states);
    
    for j = 1:length(set) %Length of training set
        if strcmp(genres{set(j)},current_genre) %See if its part of the same genre
            display(j)
            x = mfcc{set(j)}; %Pull current song MFCCs
            %Correct set to not include self
            setN = set;
            setN(j) = []; %Remove self element
            %Pass in x(current song MFCCs), Gauss(all song means and covs), setN(list of applicable song indices)
            I = mahalanSeq(x,Gauss,setN); %Get the Mahalanobis sequence of similarities (will they always bin to the same place?)
            X = states(I); %Pull the bin states

            %Now, let's use to train the Markov Matrix
            T = T + full(sparse(X(1:end - 1) , X(2 : end),1,n,n)); %Add connections
        end
    end
    
    offset = Tmin*ones(n);
    %T = T+offset; %No zero prob
    
    %Normalize transistion matrix before offset to reduce effect
    sum_T = sum(T , 2);
    T = (T./sum_T(:,ones(1,size(T , 1))));
    T = T+offset; %No zero prob
    %Normalize transistion matrix again
    sum_T = sum(T , 2);
    T = (T./sum_T(:,ones(1,size(T , 1))));
end

