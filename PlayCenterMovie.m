function [] = PlayCenterMovie(centerMovie, varargin)
% Just like PlaySideMovies, but just plays one movie in the middle! Yay.
% You really should use absoulte filepaths, but we'll try to help you if
% you gave one in the current directory. 
%
% A number of parameters are possible.  To use them, you need to specify
% their names, like this: 
%
% PlayCenterMovie('myMovieName.mov', 'shouloop', 1, 'soundclip', 'mysoundfile.mpg')
%
% Possible arguments to pass in are:
%
% soundclip: A sound file to play while the movie plays
% caption: A caption to show at the bottom of the movie
% ownsound: Set to 1 to turn on the sounds in the movie file - often we want these silent!
% shouldloop: Set to 1 to make the movie loop (until you press a key to stop it)

global EXPFOLDER EXPWIN WINDOW_PARAMS;

p = inputParser;
p.addRequired('centerMovie', @isstr);
p.addParamValue('soundclip', 0, @(x) true);
p.addParamValue('caption', '', @isstr);
p.addParamValue('ownsound', 0, @(x) true);
p.addParamValue('shouldloop', 0, @(x) true);

p.parse(centerMovie, varargin{:});
inputs = p.Results;

%Check if we got an absolute path, otherwise assume it's in the folder of
%the main experiment. (This works on macs but sure is hacky!)
if inputs.centerMovie(1) == '/'
    fullpathMovie = inputs.centerMovie;
else
    fullpathMovie = strcat(EXPFOLDER, '/', inputs.centerMovie);
end

fullpathMovie

%Ensure no keys are being pressed - solves the 'trigger finger problem'
while KbCheck; end % Wait until all keys are released.

%Prepare the SOUND 
if inputs.soundclip
    [y, freq, nbits] = wavread(input.soundclip);
    wavedata = y';
    nrchannels = size(wavedata,1);
    pahandle = PsychPortAudio('Open', [], [], 0, freq, nrchannels); % Open & buffer the default audio device
    PsychPortAudio('FillBuffer', pahandle, wavedata);

    %Start the SOUND
    t1 = PsychPortAudio('Start', pahandle, 1, 0, 1);
end

%Prepare & start the MOVIES
movie = Screen('OpenMovie', EXPWIN, fullpathMovie);
Screen('PlayMovie', movie, 1, inputs.shouldloop, inputs.ownsound);

while ~KbCheck %1 %loops until we finish the movie or get a keypress to escape
    tex=0;
    tex = Screen('GetMovieImage', EXPWIN, movie, 1);

    if (tex<=0) %Movies are over, break!
        break;
    end
    
    if tex>0
        % Draw the new texture immediately to screen:
        Screen('DrawTexture', EXPWIN, tex, [],WINDOW_PARAMS.CENTERBOX);
        % Release texture:
        Screen('Close', tex);
        
        %And draw the caption too!  Center it below the movie
        DrawFormattedText(EXPWIN, inputs.caption, WINDOW_PARAMS.CENTERBOX(1), WINDOW_PARAMS.CENTERBOX(4)+20);

    end;

    % Update display if there is anything to update:
    if (tex>0)
        vbl=Screen('Flip', EXPWIN,0,1); %clearmode | so we keep the final still up
    else
        continue
    end;

    WaitSecs(0.004); %avoid overloads
end;

%Close the MOVIES
Screen('PlayMovie', movie, 0);
Screen('CloseMovie', movie);

% Close the SOUND
if inputs.soundclip
    PsychPortAudio('Stop', pahandle);
    PsychPortAudio('Close', pahandle);
end

end


