function rmap = resourceMap()
% Generate a random layout (ordering) of the 19 terrain cards in the game.
% rmap is a vector of length 19 where rmap(k) is the resource code of the
% kth discovered terrain.  The resource codes are defined as follows:
%     0 - Nothing
%   100 - Brick
%   200 - Ore  
%   300 - Lumber
%   400 - Grain
%   500 - Wool

rmap = [0 100 100 100 200 200 200 300 300 300 300 400 400 400 400 500 500 500 500]; % the possible hexes

% Loop through 200 times (arbitrary) and swap 2 random indexes in the resourceMap array
for k= 1:200
    idx1= ceil(rand(1)*length(rmap)); % pick a first random index
    idx2= ceil(rand(1)*length(rmap)); % pick a second random index
    temp= rmap(idx1); % store the value of the first index in a temp variable
    rmap(idx1)= rmap(idx2); % swap the value from the second index to the first index
    rmap(idx2)= temp; % copy the temp variable into the second index
end