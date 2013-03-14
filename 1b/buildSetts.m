function land = buildSetts(nSett)
% Randomly generate a settlement pattern given nSett, a vector of length 3, where
% nSett(1) is the number of settlements to build on the coastline,
% nSett(2) is the number of settlements to build on the coast ring, and
% nSett(3) is the number of settlements to build on the inland ring.
% If nSett(r) is greater than the number of junctions on that ring, change
% nSett(r) to the number of junctions on that ring.
% land is an ns-by-3 matrix identifying the junctions where settlements are
% built. ns is the total number of settlements to be built. Each row
% in land identifies a junction where a settlement is built and stores
% the terrain labels of that junction. If a junction has only two
% adjacent terrains, use 0 as the third terrain label.

    % correct any erroneous numbers
    if nSett(1) > 12
        nSett(1) = 12;
    end
    if nSett(2) > 18
        nSett(2) = 18;
    end
    if nSett(3) > 6
        nSett(3) = 6;
    end
    ns = nSett(1) + nSett(2) + nSett(3); % total number of settlements
    land = zeros(ns, 3);
    count = 1;
    coastline = ringJunctions(0); % get all possible coastline positions
    rands = generateRand(nSett(1), 12); % generate the right number of random indexes
    % copy the randomly selected junctions into the return matrix
    for i = 1:nSett(1)
        land(count, 1) = coastline(rands(i), 1);
        land(count, 2) = coastline(rands(i), 2);
        count = count + 1;
    end

    coast = ringJunctions(1); % get all possible coast positions
    rands = generateRand(nSett(2), 18); % generate the right number of random indexes
    % copy the randomly selected junctions into the return matrix
    for i = 1:nSett(2)
       land(count, 1) = coast(rands(i), 1);
       land(count, 2) = coast(rands(i), 2); 
       land(count, 3) = coast(rands(i), 3); 
       count = count + 1;
    end

    inland = ringJunctions(2); % get all possible inland positions
    rands = generateRand(nSett(3), 6); % generate the right number of random indexes
    % copy the randomly selected junctions into the return matrix
    for i = 1:nSett(3)
       land(count, 1) = inland(rands(i), 1);
       land(count, 2) = inland(rands(i), 2); 
       land(count, 3) = inland(rands(i), 3); 
       count = count + 1;
    end
end

function rands = generateRand(n, b)
% generates n distinct random numbers uniformly randomly distributed
% between 1 and b
    rands = zeros(1,n);
    count = 1;
    num = ceil(rand(1)*b);
    % keep generating numbers until n distinct numbers have been created
    while count <= n
        % if the generated number is already in the list
        if listContains(rands, num)
            % generate a new number
            num = ceil(rand(1)*b);
        else 
            % otherwise add it to the list of random values
            rands(count) = num;
            count = count + 1;
            num = ceil(rand(1)*b);
        end
    end
end

function doesContain = listContains(list, num)
% determines if list contains num, returns 1 if TRUE 0 otherwise
    doesContain = 0;
    for i = 1:length(list)
        if num == list(i)
            doesContain = 1;
        end
    end
end