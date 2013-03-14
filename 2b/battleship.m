function battleship(n, ships)
% A one-player game of Battleship on an n-by-n grid
% n: number of squares on each side of the playing field
% ships: m-by-2 cell array storing information of m ships
% ships{s,1} is a string naming the type of the sth ship, s=1:m
% ships{s,2} is the integer size of the sth ship, s=1:m
% E.g., ships={'aircraft carrier', 5; 'battleship', 4; 'submarine', 3}
    close all
    figure
    axis equal off
    
    running = 1; % stops the game when you win
    moves = 0; % counts number of legal moves
    [numShips, nc] = size(ships); % holds the number of ships
    
    board = zeros(n,n); % data structure to keep track of which squares have been clicked
    [boats, shipIndex, horizontal] = initBoats(n, ships); % stores locations of the ships
    
    % display opening board
    strs={'Welcome to Battleship!', 'Click on a Square to Begin'};
    title(strs, 'Fontsize', 14)
    drawBoard(n, boats, board)
    
    % while the game is running
    while running
        [xf,yf] = ginput(1); % wait for mouse input at each step
        x = floor(xf); % get the integer value of the square clicked
        y = floor(yf); % get the integer value of the square clicked
        if x < 1 || x > n % if off the board, let the player know
            strs={'Please click on a valid square!', sprintf('Number of Moves Made: %d',moves)};
            title(strs, 'Fontsize', 14)
        elseif board(x,y) == 1 % if already clicked, let the player know
            strs={'You have already selected that square!', sprintf('Number of Moves Made: %d', moves)};
            title(strs, 'Fontsize', 14)
        else % otherwise, legal move
            board(x,y) = 1; % mark the square as used
            moves = moves + 1; % increment the moves counter
            if boats(x,y) == 1 % if there is a ship at this square
                ship = -1; % to store the ship that was hit
                for i = 1:numShips % for each of the ships on the board
                   x1 = shipIndex(i,1); % start square x
                   y1 = shipIndex(i,2); % start square y
                   x2 = x1; % end square x
                   y2 = y1; % end square y
                   if horizontal
                       x2 = x2 + ships{i,2} - 1; % adjust the end square x
                   else
                       y2 = y2 + ships{i,2} - 1; % adjust the end square y
                   end
                   if x >= x1 && x <= x2 && y >= y1 && y <= y2 % if our square is in that range
                       ship = i; % it's the ship we are looking for
                   end
                end
                % check if this move sunk the ship
                isSunk = isShipSunk(ship, shipIndex, horizontal, ships, board, n);
                if ~isSunk % not sunk, let the player know they hit a ship
                    strs={'You have hit a ship!', sprintf('Number of Moves Made: %d', moves)};
                    title(strs, 'Fontsize', 14)
                else % sunk, let the player know which ship they sunk
                    strs={sprintf('You have sunk a %s', ships{ship,1}), sprintf('Number of Moves Made: %d', moves)};
                    title(strs, 'Fontsize', 14)
                end
            else % otherwise the valid move was a miss, let the player know
                strs={'You have missed!', sprintf('Number of Moves Made: %d', moves)};
                title(strs, 'Fontsize', 14)
            end
            % check if the game is over
            allShipsSunk = 1;
            for i = 1:numShips % for each ship on the board
                % check if it is sunk
                if ~isShipSunk(i, shipIndex, horizontal, ships, board, n)
                    allShipsSunk = 0;
                end
            end
            if allShipsSunk % if all ships sunk, the player wins!
                strs={'YOU WIN!', sprintf('Number of Moves Made: %d', moves)};
                title(strs, 'Fontsize', 14)
                running = 0;
            end
            drawBoard(n, boats, board) % update board
        end
    end
end

function isSunk = isShipSunk(ship, shipIndex, horizontal, ships, board, n)
    isSunk = 1;
    if horizontal
        for i = shipIndex(ship,1):min(n,(shipIndex(ship,1) + ships{ship,2} - 1))
           if board(i,shipIndex(ship,2)) == 0
               isSunk = 0;
           end
        end
    else
        for i = shipIndex(ship,2):min(n,(shipIndex(ship,2) + ships{ship,2} - 1))
           if board(shipIndex(ship,1),i) == 0
               isSunk = 0;
           end
        end
    end
end

function drawBoard(n, boats, board)
% draws the board to the screen based on past clicks and boat positions
    hold on
    for i = 1:n
        for j = 1:n
            a = [i i+1 i+1 i i];
            b = [j j j+1 j+1 j];
            if board(i, j) == 0
                fill(a,b,'b')
            else
                if boats(i, j) == 0
                    fill(a,b,'w')
                else
                    fill(a,b,'r')
                end
            end
            plot(a,b, '-k')
        end
    end
    hold off
end

function [boats, shipIndex, horizontal] = initBoats(n, ships)
% randomly places all the boats in ships on an n-by-n grid
    boats = zeros(n,n); % data structure to keep track of which squares are ships
    
    [nr nc] = size(ships); % get the number of ships
    
    shipIndex = zeros(nr, 2); % stores the beginning square of each ship
    
    horizontal = 1; % bool to hold decision to place horizontally or vertically
    if rand(1) > .5 % randomly decide whether to place horizontally
        horizontal = 0;
    end
    
    % for each ship in the ships cell array
    for i = 1:nr
        x = ceil(rand(1)*n); % generate a random x coordinate
        y = ceil(rand(1)*n); % generate a random y coordinate
        shipFits = 0;
        while ~shipFits % keep generating randomly until the ship fits
            if boats(x,y) == 0 % if the randomly selected square is free
                if horizontal && x + ships{i,2}-1 <= n % and this won't go out of bounds
                    boatFits = 1;
                    for j = 1:(ships{i,2}-1) % check if the rest of the ship fits
                       if ~(boats(x+j,y) == 0)
                           boatFits = 0;
                       end
                    end
                    if boatFits
                        shipFits = 1;
                    end
                elseif y + ships{i,2}-1 <= n % and this won't go out of bounds
                    boatFits = 1;
                    for j = 1:(ships{i,2}-1) % check if the rest of the ship fits
                        if ~(boats(x,y+j) == 0)
                            boatFits = 0;
                        end
                    end
                    if boatFits
                        shipFits = 1;
                    end
                end
            end
            if ~shipFits % if the ship didn't fit at these coordinates
                % generate new random coordinates
                x = ceil(rand(1)*n);
                y = ceil(rand(1)*n);
            end
        end
        % mark the corresponding squares as taken
        shipIndex(i,1) = x;
        shipIndex(i,2) = y;
        if horizontal
            for j = x:(x + ships{i,2} - 1)
                boats(j,y) = 1;
            end
        else
            for j = y:(y + ships{i,2} - 1)
                boats(x,j) = 1;
            end
        end
    end
end