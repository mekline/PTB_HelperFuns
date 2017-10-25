function [] = Show_Blank()
% PTB wrapper to show a blank screen.  Uses the parameter struct to find
% out your chosen 'background' color

global EXPWIN WINDOW_PARAMS

Screen('FillRect', EXPWIN, WINDOW_PARAMS.BGCOLOR);
vbl=Screen('Flip', EXPWIN);


end

