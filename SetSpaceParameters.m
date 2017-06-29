function [WINDOW_PARAMS, KEYID] = SetSpaceParameters(Calib)
%Sets all the default parameters for a looking time experiment. 
%The types of parameters in this file are things that should never ever
%need to change, like where to put two movies if playing them side by side.
%It takes as input a Calib object which has some basics about screen size
%created during PTB initialization

global EXPWIN; 

WINDOW_PARAMS.X = Calib.screen.x;
WINDOW_PARAMS.WIDTH = Calib.screen.width;
WINDOW_PARAMS.Y = Calib.screen.y;
WINDOW_PARAMS.HEIGHT = Calib.screen.height;
WINDOW_PARAMS.WHOLESCREEN = [WINDOW_PARAMS.X, WINDOW_PARAMS.Y, WINDOW_PARAMS.WIDTH, WINDOW_PARAMS.HEIGHT];

%Keyboard/text stuff
KbName('UnifyKeyNames');
KEYID.KEYBOARD=max(GetKeyboardIndices);
KEYID.SPACE=KbName('SPACE');
KEYID.Y = KbName('y');
KEYID.N = KbName('n');
KEYID.Z = KbName('z'); %Values MK uses for R and L
KEYID.C = KbName('c');

Screen('TextSize', EXPWIN, 14);

WINDOW_PARAMS.TEXTX = Calib.screen.width*(5/12);
WINDOW_PARAMS.TEXTY = Calib.screen.height/2;
%%%%%%%%%%%
% Set video rectangle parameters
% Note: this is all relativized to monitor size
%%%%%%%%%%%

WINDOW_PARAMS.CENTER = [round((Calib.screen.width - Calib.screen.x)/2) ...
    round((Calib.screen.height -Calib.screen.y)/2)];
WINDOW_PARAMS.BLACK = BlackIndex(EXPWIN); 
WINDOW_PARAMS.WHITE = WhiteIndex(EXPWIN);
WINDOW_PARAMS.GRAY = GrayIndex(EXPWIN);

%Calculate locations of videos!
border = 30;
moviewidth = Calib.screen.width/2 - 2*(border); %Pick a size that can fit 2 movies side by side
movieheight = moviewidth * (3/4); %Set the aspect ratio! Change this if you have widescreen videos

topheight = (Calib.screen.height-movieheight)/3;
leftcorner = border-5;
rightcorner = Calib.screen.width/2 + border;
centercorner = (Calib.screen.width/2)-(moviewidth/2);

WINDOW_PARAMS.LEFTBOX = [leftcorner,topheight,leftcorner+moviewidth,topheight+movieheight];
WINDOW_PARAMS.RIGHTBOX = [rightcorner,topheight,rightcorner+moviewidth,topheight+movieheight];
WINDOW_PARAMS.RIGHTBOX = [centercorner, topheight, centercorner+moviewidth, topheight + movieheight];

end

