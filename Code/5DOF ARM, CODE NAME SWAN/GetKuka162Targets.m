function [T TI] = GetKuka162Targets(steps)
% get example workspace targets
% Uses Peter Corke's robotics toolbox
% CLASSICAL DH used here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Dr. Ian Howard
% Associate Professor (Senior Lecturer) in Computational Neuroscience
% Centre for Robotics and Neural Systems
% Plymouth University
% A324 Portland Square
% PL4 8AA
% Plymouth, Devon, UK
% howardlab.com
% 31/03/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define targets for square
% cartesian straight line path between poses
T=[];
T(:,:,1) = transl(-1000, 0, 100) % define the start point
T(:,:,2) = transl(-1000, 400, 100) % define the start point
T(:,:,3) = transl(-1000, 400, 900) % define the start point
T(:,:,4) = transl(-1000, -400, 900) % define the start point
T(:,:,5) = transl(-1000, -400, 100) % define the start point
T(:,:,6) = transl(-1000, 400, 100) % define the start point
T(:,:,7) = transl(-1000, 0, 100) % define the start point

% interpolate between targets with steps
TI = [];
for idx = 1: (length(T)-1)
    offset = (idx -1)* steps;
    tmp = ctraj(T(:,:,idx), T(:,:,idx+1), steps); 	% compute a Cartesian path
    for tidx = 1:steps
        TI(:,:, tidx+offset) = tmp(:,:,tidx); 	% compute a Cartesian path
    end
end