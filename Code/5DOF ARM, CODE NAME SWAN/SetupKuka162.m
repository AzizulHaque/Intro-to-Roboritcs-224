function [ TLP_robot midConfig controlLimits w ]  =  SetupKuka162(robotName)
% setup the Kuka16-2 robot
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set workspace
w=[-400 400 -400 400 0 600];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% setup DH parameters anbd build links
%
% A Link object holds all information related to a robot joint and link such as
% kinematics parameters, rigid-body inertial parameters, motor and
% transmission parameters

% Kuka 16_2 robot

% DH table row 1
alpha(1)= -pi/2; % link twist
a(1)=60; % link length
d(1) = 40; % link offset
theta(1)=0; % joint angle
Qmin(1) = d2r(-185);
Qmax(1) = d2r(185);
L(1) = Link([theta(1) d(1) a(1) alpha(1) ] );

% DH table row 2
alpha(2)= 0; % link twist
a(2)=108; % link length
d(2) = 0; % link offset
theta(2)=90; % joint angle
Qmin(2) = d2r(-90);
Qmax(2) = d2r(90);
L(2) = Link([theta(2) d(2) a(2) alpha(2) ]);

% DH table row 3
alpha(3)= d2r(0); % link twist
a(3)=108; % link length
d(3) = 90; % link offset
theta(3)=d2r(90); % joint angle
Qmin(3) = d2r(-90);
Qmax(3) = d2r(90);
L(3) = Link([theta(3) d(3) (3) alpha(3)] );

% DH table row 4
alpha(4)= d2r(0); % link twist
a(4)=103; % link length
d(4) = 0; % link offset
theta(4)=90; % joint angle
Qmin(4) = d2r(-90);
Qmax(4) = d2r(90);
L(4) = Link([theta(4) d(4) a(4) alpha(4)] );





% midpoint of control
midConfig = 0.5 * Qmin +  0.5 * Qmax;

% control parameter trange limits
% organized as: num of params (3) x min-max (2)
%controlLimits = [[-pi/2 pi/2]; [-pi/2 pi/2]; [-pi/2 pi/2]; [-pi/2 pi/2];];
controlLimits = [Qmin' Qmax'];

% build serial links together
TLP_robot = SerialLink(L, 'name', robotName);
TLP_robot