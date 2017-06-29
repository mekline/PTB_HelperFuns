function [datafilepointer] = AssignDataFile()
% This returns a file pointer that you can use to store
% info about trials in the experiment and/or subject responses.
%
%, it throws an error if we already ran that subject! 

global EXPERIMENT SUBJECT DATAFOLDER

datafilename = strcat(DATAFOLDER,'/',  EXPERIMENT, '_', SUBJECT,'.dat') % name of data file to write to

% check for existing result file to prevent accidentally overwriting
% files from a previous subject/session (except for subject numbers > 99):
if fopen(datafilename, 'rt')~=-1
    %fclose('all');
    error('Result data file already exists! Choose a different subject ID.');
    Closeout_PTool;
else
    datafilepointer = fopen(datafilename,'wt'); % open ASCII file for writing
end


end

