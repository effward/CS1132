function outStr = encrypt(inStr, keyFile, chapter)
% An implementation of the book cipher for encryption.
% inStr: plaintext to be encrypted, a string
% keyFile: filename of the book (in ASCII format) to be used as the key
% chapter: the number of the chapter to be used as the key, an integer
% outStr: ciphertext from encrypting inStr, a string
    % build the key string
    key = getKeyString(keyFile, chapter);
    
    % convert the key string to a key cell array
    keyCellArr = str2cellarray(key);
    
    letterInd = ones(1,26); % array to keep track of where each letter's search begins
    outStr = ''; % place to store encrypted string
    % encrypt the string
    for i = 1:length(inStr) % for every character in the input string
        if isletter(inStr(i))
            letter = upper(inStr(i)); % make it uppercase
            matchFound = 0;
            for j = letterInd(double(letter)-64):length(keyCellArr) % loop through remaining key words
               if ~matchFound && strcmp(keyCellArr{j}(1), letter) % if a match is found
                   outStr = [outStr ' ' num2str(j)]; % add it to the encrypted string
                   letterInd(double(letter)-64) = j+1; % keep track of where to begin next search for this letter
                   matchFound = 1;
               end
            end
        end
    end
                    