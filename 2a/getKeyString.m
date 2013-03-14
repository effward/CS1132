function key = getKeyString(keyFile, chapter)
% returns the full key string for the specified file and chapter
% keyFile: filename of the book to be used as the key
% chapter: the number of the chapter to be used, an integer
% key: the UPPERCASE key string with non-letters removed
    fid = fopen(keyFile, 'r'); % open the file for reading
    inRightChapter = 0; % bool to track if we are reading the right chapter
    key = ''; % string to store the key in
    while ~feof(fid) % end loop at end of file
        line = fgetl(fid); % read next line in the file
        line = upper(deblank(line)); % remove trailing whitespace and capitalize
        if length(line) >= 11
            if strcmp(line(1:9),'[CHAPTER]') % check if this line denotes beginning of chapter
                if inRightChapter % if already in the right chapter
                    inRightChapter = 0; % this signifies end of right chapter
                else % otherwise check if it is the right chapter
                    moreDigits = 1; % bool to keep track of whether there are more chapter digits
                    digitCount = 11; % starting location of chapter digits
                    while moreDigits
                        digit = str2num(line(digitCount)); % try to convert next digit to a number
                        if isempty(digit) % if conversion fails
                            moreDigits = 0; % we've reached the end of the chapter digits
                        else % otherwise, check the for another digit
                            digitCount = digitCount + 1;
                        end
                    end
                    lineChapter = str2num(line(11:digitCount-1)); % grab out the chapter number
                    if chapter == lineChapter % check if this is the right chapter
                        inRightChapter = 1; % mark that we are now in the right chapter
                    end
                end
            else
                if inRightChapter % if we are in the right chapter
                    if length(line) >= 1 % and the line isn't empty
                        key = [key ' ' line]; % append it to our key string
                    end
                end
            end
        else
            if inRightChapter % if we are in the right chapter
                if length(line) >= 1 % and the line isn't empty
                    key = [key ' ' line]; % append it to our key string
                end
            end
        end
    end
    % remove all the non-letter characters from key string
    for i = 1:length(key)
        if ~(isletter(key(i)) || isspace(key(i))) % if this character isn't a letter or space
            key(i) = ' '; % replace it with a space
        end
    end
end