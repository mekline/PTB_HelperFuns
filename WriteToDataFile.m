function howmany = WriteToDataFile(infoVector)

% A simple function that writes out whatever you give it, with commas
% between!  It makes sure everything is a char before sending it along.
% Note that WriteToDataFile expects a cellarray (curly braces) because
% it allows you to stick anything into this vector...

global DATAFILE

howmany = length(infoVector);


stringOut = '';

for v=1:length(infoVector)
    if isnumeric(infoVector{v})
        nextString = num2str(infoVector{v});
    else
        nextString = char(infoVector{v});
    end
    
    if stringOut
        stringOut = strcat(stringOut, ',', nextString);
    else
        stringOut = nextString;
    end
end
        
stringOut = strcat(stringOut, '\n');

% Write trial result to the file!
fprintf(DATAFILE, stringOut);


end