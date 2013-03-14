function n = diceRoll(p)
% n is the scalar outcome of rolling p fair, 6-sided dice

FACES=6; % the number of faces on the die
n=0; % variable to store the total of the p rolls

% Rolls a die p times and sums the outcomes
for k = 1:p
    face = ceil(rand(1)*FACES); % simulates the roll of one die
    n = n + face; % adds the roll to the total
end