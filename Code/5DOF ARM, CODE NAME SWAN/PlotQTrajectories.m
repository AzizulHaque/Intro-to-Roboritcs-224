function PlotQTrajectories(q, robotName)
% Plot q-control angular trajectories
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

prop{1} = 'r.-';
prop{2} = 'b.-';
prop{3} = 'k.-';
prop{4} = 'm:';
prop{5} = 'g:';
prop{6} = 'y:';

figure
hold on
h=title(sprintf('%s: Angular Trajectories', robotName));
set(h, 'FontSize', 20);
for aidx=1:6
    h = plot(q(:,aidx), prop{aidx});
    set(h, 'LineWidth', 3);
end
h = legend('A1', 'A2','A3','A4','A5','A6')
set(h, 'FontSize', 20);
h = xlabel('Time Point[arb]]');
set(h, 'FontSize', 20);
h = ylabel('Angle [rad]');
set(h, 'FontSize', 20);
set(gca, 'FontSize', 20);
