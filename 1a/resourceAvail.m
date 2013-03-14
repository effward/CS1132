function amap = resourceAvail(rmap)
% Assign an availability value to each quadrant and print the resulting
% game board (resource and availabilitly value at each quadrant).
% rmap: vector of length 19 representing the resource map (vector returned
%       from function resourceMap)
% amap: vector of length 19 storing the availability values such that
%       amap(k) is the availability value of the kth quadrant.
% The desert terrain gets the availability value of 7.
% Each non-desert terrain gets an availability value by rolling two fair
% dice, excluding the value 7.

amap= zeros(1,19); % bins to store availability values, amap(k) corresponds to rmap(k)

% loop through the rmap array and for each hex, generate an availability value
for k= 1:19
    if rmap(k) == 0 % if the hex is a desert
        amap(k)= 7; % the availability value defaults to 7
        fprintf('Robber\t%d', amap(k))
    else % otherwise generate a random value
        roll= 7; % variable to store the roll that will correspond to rmap(k)
        while roll == 7 % keep generating rolls until we get a non-7 roll
            roll= diceRoll(2); % simulate rolling 2 dice
        end
        amap(k)= roll; % set the availability value for hex k
    end
    % print the resource and availability corresponding to hex k
    if rmap(k) == 100
        fprintf('Brick\t%d', amap(k))
    elseif rmap(k) == 200
        fprintf('Ore\t\t%d', amap(k))
    elseif rmap(k) == 300
        fprintf('Lumber\t%d', amap(k))
    elseif rmap(k) == 400
        fprintf('Grain\t%d', amap(k))
    elseif rmap(k) == 500
        fprintf('Wool\t%d', amap(k))
    end
    % print new line after 4 hexes are printed
    if mod(k,4) == 0
        fprintf('\n')
    else % otherwise print tabs between hexes
        fprintf('\t')
    end
end