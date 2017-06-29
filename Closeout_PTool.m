function [] = Closeout_PTool()
%Just does the boilerpplate to close out of PTB properly

pause(0.1); %so we don't crash/close right away

PsychPortAudio('Close');
Screen('CloseAll');
ShowCursor;
fclose('all');
Priority(0);
clear all;

end

