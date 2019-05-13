function q = GetInterpolatedJointAngles(servoAngleS, servoAngleE, steps)
% linearly interpolate between joint angles

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

servoCnt = size(servoAngleS, 2);
q = [];

% for all steps
for sidx =  1:steps
    
    % linear combination of end point start at 0
    b = (sidx - 1)/ (steps - 1);
    
    % linear combination of start point start at 1
    a = 1 - b;
    
    % for to all servos
    for servoID = 1:servoCnt
        
        % record q control values
        q(sidx,servoID) =  a * servoAngleS(servoID) + b * servoAngleE(servoID);
    end
end

