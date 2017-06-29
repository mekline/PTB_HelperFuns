function [] = Show_Image(impath, varargin)
% PTB wrapper to show a picture. Image needs to be
% an absolute path. If you don't specify a box it
% fills the screen

global EXPWIN WINDOW_PARAMS

p = inputParser;
p.addRequired('impath');
p.addParamValue('box', WINDOW_PARAMS.WHOLESCREEN, @ismatrix); 

p.parse(impath, varargin{:});
inputs = p.Results;
imageArray = imread(impath);

Screen('PutImage', EXPWIN , imageArray, inputs.box);
Screen('flip',EXPWIN);



end

