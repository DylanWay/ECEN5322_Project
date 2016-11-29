function [genre,P] = gCount(genres,set,seq)
    % changed call to pass in set to get true indices

    %Now, count the items of the genres array
    counts = zeros(6,1); %Number of genres
    g = {'classical','electronic','jazz_blues','metal_punk','rock_pop','world'}; %The genres, because I hate figuring out whats in a cell array
    
    for i = 1:length(g)
        % I think the indices here were accidentally of the reduced set
        % again
        %ind = find(strcmp({genres{seq}},g{i}));
        ind = find(strcmp({genres{set(seq)}},g{i}));
        counts(i) = length(ind);
    end
    
    [~,I] = max(counts);
    
    genre = g{I};
    P = counts./sum(counts);
end