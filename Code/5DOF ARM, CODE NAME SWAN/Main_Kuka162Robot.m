% define DH table for 6DOF Kuka 16-2 robot
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

close all
clear all
clc

% add path for rvctools

addpath('C:\Users\Azizul Haque\Documents\MATLAB\Add-Ons\Toolboxes\Robotics Toolbox for MATLAB\code\robot\data\');

% startup robotics toolbox if not done already
run('startup_rvc');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% build DH representation of Kuka 16-2 robot
% set flags

% generate static configuration plot
wantSimplePlot=1;

% generate interactive configuration plot  
wantInteactivePlot = 1;

% generate scatter of end-effector posiion range on interactive configuration plot  
wantScatterPlot = 1;

% generate inverse kinematicanimation
wantIKAnimation=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get the robot parameters

% specify name of robot
robotName = 'Muhammed Haque Swan Simulation';

% setup the Kuka16-2 robot
[ TLP_robot midConfig controlLimits w ]  =  SetupKuka162(robotName);

% get example workspace targets
[Targets TI] = GetKuka162Targets(10);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate simpe plot of robot endpoint
% if(wantSimplePlot)
%     figure;
%     TLP_robot.plot(midConfig,  'noshadow', 'workspace', w);
%     
%     % can use forward kinematics function in robotics toolbox too
%     %Tmid = TLP_robot.fkine(midConfig);
%     
%     h=title(sprintf('%s: Configuation', robotName));
%     set(h, 'FontSize', 20);
%     
%     % axis labels
%     set(gca, 'FontSize', 20);
%     
%     input('Hit return to proceed');
%     close all
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate interative plot of robot endpoint
if(wantInteactivePlot)
    % build serial links together
    figure;
    TLP_robot.plot(midConfig,  'noshadow', 'workspace', w);
    
    % set the joint limits
    TLP_robot.qlim = controlLimits;
    
    % use interactive mode
    TLP_robot.teach
    
    h=title(sprintf('%s: Interactive robot control', robotName));
    set(h, 'FontSize', 20);
    
    % axis labels
    set(gca, 'FontSize', 20);
    
    input('Hit return to proceed');
    close all
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate scatter plot of robot endpoint
if(wantScatterPlot)
    
    % Robot working area displayed by random uniformly distributed control parameters
    samples = 10000;
    
    % draw samples from a uniform distribition between min and max limits
    % syntax: DrawFromUniformDistribution(min, max, samples)
    theta1Rand = DrawFromUniformDistribution(controlLimits(1,1),  controlLimits(1,2), samples);
    theta2Rand = DrawFromUniformDistribution(controlLimits(2,1),  controlLimits(2,2), samples);
    theta3Rand = DrawFromUniformDistribution(controlLimits(3,1),  controlLimits(3,2), samples);
    theta4Rand = DrawFromUniformDistribution(controlLimits(4,1),  controlLimits(4,2), samples);
%    theta5Rand = DrawFromUniformDistribution(controlLimits(5,1),  controlLimits(5,2), samples);
 %   theta6Rand = DrawFromUniformDistribution(controlLimits(6,1),  controlLimits(6,2), samples);
    
    % can use forward kinematics function in robotics toolbox too
    % calculate endpoint poisiton for random inputs
    q = [theta1Rand theta2Rand theta3Rand theta4Rand];
    [TRand, All]= TLP_robot.fkine(q);
    
    % extract homonegenous matrices from SE3 object
    TT=TRand.T;
    
    % extract position from homogeneous matrices
    TP = squeeze(TT( 1:3, 4, :));
    
    figure
    % plot the scattered points
    % plot3(x,y,z), where x, y and z are three vectors of the same length,
    % plots a line in 3-space through the points whose coordinates are the
    h = plot3(TP(1,:), TP(2,:), TP(3,:), 'r.');
    set(h, 'LineWidth', 3);
    TLP_robot.plot(midConfig,  'noshadow', 'workspace', w);
    
    h=title(sprintf('%s:  Working area', robotName));
    set(h, 'FontSize', 20);
    
    % axis labels
    set(gca, 'FontSize', 20);
    
    % set the joint limits
    TLP_robot.qlim = controlLimits;
    
    % use interactive mode
    TLP_robot.teach
    
    input('Hit return to proceed');
    close all
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate animation of inverse kinematics
% if(wantIKAnimation)
%     
%     % draw target
%     figure
%     
%     %  % extract position from homogeneous matrices
%     TP = squeeze(Targets( 1:3, 4, :));
%     
%     % plot the desired trajectory
%     % plot3(x,y,z), where x, y and z are three vectors of the same length,
%     % plots a line in 3-space through the points whose coordinates are the
%     h = plot3(TP(1,:), TP(2,:), TP(3,:), 'k-');
%     set(h, 'LineWidth', 3);
%     
%     h=title(sprintf('%s:  Trajectory Animation', robotName));
%     set(h, 'FontSize', 20);
%     
%     % axis labels
%     set(gca, 'FontSize', 20);
%     
%     % Moving robot end-effector along trajectory specified in extrinsic space
%     % now solve the inverse kinematics
%     % need to set mask to select the 6DOFs
%     %q = TLP_robot.ikine(T, 'mask',[1 1 1 1 1 1]);
%     q = TLP_robot.ikunc(TI);
%     
%     % save 1 control values to file
%     save(robotName, 'q');
%     
%     % now move robot and generate animation due to specified q trajectories
%     TLP_robot.plot(q);
%     
%     % Plot q-control angular trajectories
%     PlotQTrajectories(q, robotName);
%     
% end


