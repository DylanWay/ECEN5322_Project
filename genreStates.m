for i = 1:length(g)
    display(g{i})
    ind = strcmp(genres,g{i});
    ind(R) = [];
    dif_states = unique(states(ind));
    for j = 1:length(dif_states)
        count = sum(states(ind) == dif_states(j));
        fprintf('Count of %d: %d\n',dif_states(j),count)
    end
    fprintf('\n')
end