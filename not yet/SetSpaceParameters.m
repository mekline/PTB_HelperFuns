function WINDOW_PARAMS = SetSpaceParameters(Calib)
%Sets all the default parameters for a looking time experiment. 
%The types of parameters in this file are things that should never ever
%need to change, like where to put two movies if playing them side by side.
%It takes as input a Calib object which has some basics about screen size
%created during PTB initialization

global EXPWIN WINDOW_PARAMS; 

%Keyboard stuff
KbName('UnifyKeyNames');
WINDOW_PARAMS.KEYBOARD=max(GetKeyboardIndices);
WINDOW_PARAMS.SPACE=KbName('SPACE');
WINDOW_PARAMS.Y = KbName('y');
WINDOW_PARAMS.N = KbName('n');
WINDOW_PARAMS.Z = KbName('z'); %Values MK uses for R and L
WINDOW_PARAMS.C = KbName('c');

Screen('TextSize', EXPWIN, 14);

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

