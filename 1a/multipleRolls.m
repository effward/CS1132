function v = multipleRolls(p,q)
% Estimate probabilities of the outcomes from rolling p dice in q trials
% p: number of 6-sided fair dice
% q: number of trials. In each trial roll p fair dice
% v: length 6*p vector of probabilities of outcomes: v(1) is prob of
% outcome 1, v(2) is prob of outcome 2, ..., v(6*p) is prob of outcome 6*p

v = zeros(1,6*p); % bins to store counts of rolls
                            % v(i) is the number of occurences of roll i

% Roll p dice q times and count up the occurences of each roll
for k=1:q
    roll= diceRoll(p); % simulates rolling p dice
    v(roll)= v(roll) + 1; % increments the count for the resulting roll
end

v= v / q; % converts the counts to probabilities by dividing by the number of trials