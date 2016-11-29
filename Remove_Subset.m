function [ test_data ] = Remove_Subset( num_remove, genres, g )
    % Makes a random selection of songs to remove and later use as test
    % data
    
    % g is a list of the possible genres
    % num_remove is an array containing the number of each genre to remove
    % genres is an array of the song's genres
    rm = [5,5,5,5,5,5]; %Let's experiment with a subset of 25 songs, 5 from each genre

    test_data = zeros(sum(rm),1);
    cur = 1;
    for i = 1:length(g)
        ind = find(strcmp(genres,g{i}));

        %Now, remove rm(i) of these
        r = randi([min(ind) max(ind)],rm(i),1);

        %We have the indices to be removed, gotta reformat the M matrix
        test_data(cur:(cur-1)+rm(i)) = r;
        cur = cur + rm(i);
    end
end

