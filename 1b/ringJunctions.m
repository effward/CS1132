function junct = ringJunctions(jcode)
% junct is a matrix identifying all junctions on ring jcode.
% jcode is an integer indicating the ring on which the junction lies:
% 0 indicates coastline, 1 indicates coast ring, 2 indicates inland ring
% junct is an nj-by-nt matrix storing the terrain labels (integers 1..19) 
% where nj is the number of junctions in ring jcode and nt is the number 
% of terrains that make up each junction in ring jcode.
coastline = linspace(1, 12, 12);
coast = linspace(13, 18, 6);
inland = [19];
if jcode == 0
    % coastline ring
    junct = zeros(length(coastline), 2); % initialize empty matrix
    % for every terrain in the coastline ring
    for i = 1:length(coastline)
        % choose terrain i and set the first part of the row in the matrix
        junct(i, 1) = coastline(i);
        % if we are not on the 12th terrain
        if i + 1 <= length(coastline)
            % set the second part of the row to the next terrain hex
            junct(i, 2) = coastline(i + 1);
        % otherwise we are on the 12th (final) terrain hex
        else
            % set the second part of the row to the first terrain hex
            junct(i, 2) = coastline(1);
        end
    end
elseif jcode == 1
    % coast ring
    junct = []; % initialize empty matrix
    j = 1; % index into coastline terrain array
    % for every terrain in the coast ring
    for i = 1:length(coast)
        % add three rows to the matrix for the three junctions adjacent to
        % this hex on this ring
        
        % first row
        if j - 1 > 0
            junct = [junct; coast(i), coastline(j), coastline(j-1)];
        else % wrap the coastline array instead of going out of bounds
            junct = [junct; coast(i), coastline(j), coastline(length(coastline))];
        end
        % second and third rows
        if j + 1 <= length(coastline)
            junct = [junct; coast(i), coastline(j), coastline(j+1)];
            % third row
            if i + 1 <= length(coast)
                junct = [junct; coast(i), coast(i+1), coastline(j+1)];
            else
                junct = [junct; coast(i), coast(1), coastline(j+1)];
            end
        else % wrap the coastline array instead of going out of bounds
            junct = [junct; coast(i), coastline(j), coastline(1)];
            % third row
            if i + 1 <= length(coast)
                junct = [junct; coast(i), coast(i+1), coastline(1)];
            else
                junct = [junct; coast(i), coast(1), coastline(1)];
            end
        end 
        j = j + 2; % move forward in the coastline array to stay lined up
    end
elseif jcode == 2
    % inland ring
    junct = zeros(length(coast),3);
    % for every terrain in the coast ring
    for i = 1:length(coast)
       % choose terrain i and set the first parts of the row in the matrix
       junct(i, 1) = 19;
       junct(i, 2) = coast(i);
       % if we are not on the last terrain
        if i + 1 <= length(coast)
            % set the last part of the row to the next terrain hex
            junct(i, 3) = coast(i + 1);
        % otherwise we are on the final terrain hex
        else
            % set the last part of the row to the first terrain hex
            junct(i, 3) = coast(1);
        end
    end
else
    % error
    junct = [];
end
