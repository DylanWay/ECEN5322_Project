function est = MarkovEstimate(T,seq)
    %Given a sequence and T matrix, figure out probabilities
    %Let's assume uniform distribution for inputs
%     t = 1/length(T); %1/6 prob of each genre

    %We need to compute partial ratios
    Pi = ones(length(T));%Partial ratios
    
    %State pairs
    x = [seq(1:length(seq)-1), seq(2:length(seq))];
    Lin = sub2ind(size(T{1}),x(:,1),x(:,2));
    
    P = zeros(length(T),1);
    
    for i = 1:length(Lin)
        %Compute partial ratios, first get probability from each linear
        %index
        %ROWS are the numerator
        %COLUMNS are the denominator
        for j = 1:length(T)
            P(j) = T{j}(Lin(i)); %Get the transisiton probabilities
        end
        
        %Now, divide by columns, multiply by rows
        Pp = P*(P.^-1)';
        Pi = Pi.*Pp;
        
%         if i == 10
%            break 
%         end
    end
        
    %Sum is the partial prob
    est = sum(Pi).^-1;
    est(isnan(est)) = 0;
end