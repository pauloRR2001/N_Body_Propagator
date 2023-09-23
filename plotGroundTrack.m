function [] = plotGroundTrack(x,z,radius,time,t0,tf)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Function Call
% the function is called by main to generate output plot
%
% Input Arguments
%
% x // array of x coordinates
% y // array of y coordinates
% z // array of z coordinates
% r // array of radius at a given time

% Output Arguments
% the function outputs a 2D graph that models the groundtrack of the object
% or the projection of its position on the surface of the planet translated
% to latitude/longitude scale

% Function Description
% Displays two graphs, a plot of radius vs time throughout the lifecycle
% of the object in orbit, and a plot of latitude vs longitude that 
% visualizes the project of the position of the object onto the surface
% of the planet in degrees. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

grayColor = [.7 .7 .7]; % non standard gray color

phi = acos(z / radius); % vertical angle of spherical coordinates

lat = phi - pi / 2; %% latitude in radians

%j_0 = int16((t0 / tf)*(length(time) + 1)) + 1; % stating time index (integer)

%% ____________________
%% CALCULATIONS

lon = acos(x ./ (radius .* sin(phi))) - pi / 2; % longitude in radians

%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS

figure('Name','Object Parameters');

sgtitle('Object Parameters')

subplot(2,1,2)
plot(time,radius(1:length(time)), 'b','LineWidth', 2); % plot radius vs time

title('Object Radius vs Time')
set(gca,'Color','w')
ylabel('Radius (km)')
xlabel('Time (sec)')
set(gca,'Color', grayColor)
grid on

subplot(2,1,1)
plot(lon * 180 / pi, lat * 180 / pi, 'r.') % plot longitude vs latitude in degrees

title('Object GroundTrack')
set(gca,'Color','w')
ylabel('Latitude (degrees)')
xlabel('Longitude (degrees')
set(gca,'Color', grayColor)
grid on;

set(gcf,'units','normalized','outerposition',[0 0 0.5 1]);

end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.