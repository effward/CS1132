function outStr = decrypt(inStr, keyFile, chapter)
% An implementation of the book cipher for decryption.
% inStr: ciphertext to be decrypted, a string
% keyFile: filename of the book (in ASCII format) to be used as the key
% chapter: the number of the chapter to be used as the key, an integer
% outStr: plaintext from decrypting inStr, a string
    % build the key string
    key = getKeyString(keyFile, chapter);
    
    % covert the key string to a key cell array
    keyCellArr = str2cellarray(key);
    
    outStr = ''; % place to store decrypted string
    % decrypt the string
    in = str2num(inStr);
    for i = 1:length(in)
       outStr = [outStr keyCellArr{in(i)}(1)];
    end