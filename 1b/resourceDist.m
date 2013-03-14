function res = resourceDist(n,land,rmap,amap)
% Simulate n rounds of our one-player version of Settlers of Catan and 
% draw a plot showing resource accumulation over time.
% land is the random settlement pattern returned by function buildSetts.
% All settlements are owned by the player.
% rmap is the resource map returned by function resourceMap: rmap(k) is the
% resource code of the kth terrain, k=1:19.
% amap is the resource availability map returned by function resourceAvail:
% amap(k) is the availability value of the resource on the kth terrain, k=1:19.
% In each round, two fair dice are rolled; let the outcome be d:
% If d is 7, then a robber steals as much resource from the player as it
% can, up to 10 units of each resource. (The robber does not want more
% than 10 units of each resource at a time.)
% If d is not 7, each settlement on a junction adjacent to the terrain with 
% with resource availability value d gets d units of that resource.
% res is a 5-by-n matrix tracking the resources owned by the player:
% res(i,j) is the number of units of resource i owned by the player after
% the jth round.
% i=1 -> Brick
% i=2 -> Ore 
% i=3 -> Lumber
% i=4 -> Grain
% i=5 -> Wool
    close all
    res = zeros(5,n+1); % add extra column to eliminate special case considerations
    for i = 2:n+1
        % roll 2 fair 6 sided dice
        d = diceRoll(2);
        if d == 7
            % robber steals
            res(1,i) = max(0,res(1,i-1)-10);
            res(2,i) = max(0,res(2,i-1)-10);
            res(3,i) = max(0,res(3,i-1)-10);
            res(4,i) = max(0,res(4,i-1)-10);
            res(5,i) = max(0,res(5,i-1)-10);
        else
            % produce resources
            for j = 1:length(amap)
                if amap(j) == d
                    numSetts = playerOn(j, land);
                    if numSetts > 0
                        res(rmap(j)/100, i) = max(res(rmap(j)/100, i-1), res(rmap(j)/100,i)) + d*numSetts;
                    end
                end
            end
            % update other resource totals for this turn
            res(1,i) = max(res(1,i),res(1,i-1));
            res(2,i) = max(res(2,i),res(2,i-1));
            res(3,i) = max(res(3,i),res(3,i-1));
            res(4,i) = max(res(4,i),res(4,i-1));
            res(5,i) = max(res(5,i),res(5,i-1));
        end
    end
    % chop off the extra column
    res = res(:, 2:n+1);
    % plot
    xaxis = linspace(1,n,n);
    plot(xaxis, res(1, :), 'r', xaxis, res(2, :), 'k', xaxis, res(3, :), 'g', xaxis, res(4, :), 'y', xaxis, res(5, :), 'c')
    xlabel('Turn Number')
    ylabel('Resource Quantity (units)')
    title('Resource Quantities Over a Game of Settlers of Catan')
    legend('Brick', 'Ore', 'Lumber', 'Grain', 'Wool') 
end

function numSetts = playerOn(hex, setts)
% returns the number of settlements that the player has on hex
    numSetts = 0;
    [nr nc] = size(setts);
    for i = 1:nr
        if setts(i,1) == hex || setts(i,2) == hex || setts(i,3) == hex
            numSetts = numSetts + 1;
        end
    end
end