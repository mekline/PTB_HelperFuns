function [] = Text_Show(message, varargin);
%This puts some text up on the screen in a default size & location

%Get current Text settings so we can use them as defaults
global EXPWIN WINDOW_PARAMS

DefaultFont = Screen('TextFont',EXPWIN);
DefaultSize = Screen('TextSize',EXPWIN);
DefaultStyle = Screen('TextStyle', EXPWIN);

%Check for additional parameters!
p = inputParser;
p.addRequired('message', @isstr);
p.addParamValue('color', WINDOW_PARAMS.WHITE, @(x) true);
p.addParamValue('start_x', floor(WINDOW_PARAMS.TEXTX), @(x) true);
p.addParamValue('start_y', floor(WINDOW_PARAMS.TEXTY), @(x) true);
p.addParamValue('bounding_characters', 60, @(x) true);
p.addParamValue('font', DefaultFont, @(x) true);
p.addParamValue('size', DefaultSize, @(x) true);
p.addParamValue('style', DefaultStyle, @(x) true);

p.parse(message, varargin{:});
inputs = p.Results;

%Update fonts and size, if any:
% Select specific text font, style and size:
Screen('TextFont',EXPWIN, inputs.font);
Screen('TextSize',EXPWIN, inputs.size);
Screen('TextStyle', EXPWIN, inputs.style);

% Clear screen to background color
Screen('FillRect', EXPWIN, WINDOW_PARAMS.BLACK);
% ...and flip it up. Initial display and sync to timestamp:
vbl=Screen('Flip', EXPWIN);

%Display the message
DrawFormattedText(EXPWIN, inputs.message, inputs.start_x, inputs.start_y, inputs.color, inputs.bounding_characters);

vbl=Screen('Flip', EXPWIN);




