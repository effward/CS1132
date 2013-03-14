function ca = str2cellarray(str)
% Convert a string to a cell array of words (strings).
% str: a string storing only letters and spaces. str may start (end) with
% a letter or one or more spaces.
% ca: a 1-d cell array storing each word in a cell; words are delimited by
% one or more spaces.
% Example: If str is 'Look for a space followed by a letter '
% then ca is {'Look','for','a','space','followed','by','a','letter'}
    ca = {};
    begin = 1;
    stop = 1;
    count = 1;
    for i = 1:length(str)
        if isletter(str(i))
            stop = stop + 1;
        elseif isspace(str(i))
            if ~(begin == stop)
                ca{count} = str(begin:stop-1);
                count = count + 1;
                stop = stop + 1;
                begin = stop;
            else
                stop = stop +1;
                begin = stop;
            end
        else
            stop = stop + 1;
            begin = stop;
        end
    end
    if ~(begin == stop)
        ca{count} = str(begin:stop-1);
    end