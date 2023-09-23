%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Problem Description: The following program calculates the position of a
% satellite at any time t within a timeline given initial conditions. It
% uses the built in function ode45 to calculate position and velocity
% analytically based on Kepler's laws and Newton's law of gravitation. With
% these results it plots two graphs: a 2D groundtrack of latitude and
% longitude, and a 3D animated plot of XYZ position vs time.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
clc;
clear variables;
close all;
beep off;

universalConstants % get planet constants, earth in this case

%[theta, phi, altitude, vel0, bounds, m, lat, lon, dir] = inputRead(); % initial conditions 
theta=0; phi=pi/2; altitude=1400; vel0=[0 8 3]; bounds=[0 300 86400]; m=5; lat=40; lon=40; dir='E';

groundZ = R * sin(lat);
radG = R * cos(lat);

% Computes rotational offset out of 2pi based on longitude for where the station starts
gSet = lon;
if(dir == -1)
    gSet = 2 * pi - gSet;
end

xdot0 = vel0(1); % velocity in x direction
ydot0 = vel0(2); % velocity in y direction
zdot0 = vel0(3); % velocity in z direction

t0 = bounds(1); % initial time
tstep = bounds(2); % time frame step
tf = bounds(3); % ending time of simulation

time = 0:tstep:tf; % time frame vector

%% ____________________
%% CALCULATIONS

gPos = groundStation(time, gSet, groundZ, radG); % All positions of the ground station over time

r = R + altitude; % distance from center of planet to object

[tout, a, position] = getDE(time, r, theta, xdot0, ydot0, zdot0, phi); % differential equation solver

x = position(:,1); % vector of x coordinates as time progresses
y = position(:,2); % vector of y coordinates
z = position(:,3); % vector of z coordinates

access = accessCheck(gPos, position); % Access as a boolean for each point in time

radius = sqrt(x .^ 2 + y .^ 2 + z .^ 2); % radius of each point as time progresses

deorbited = 0;
escaped = 0;
for i = 1:length(radius) % this for loop spots critical points in the position matrix

    if (radius(i) <= R) % checks if the object hits the planet
        tf = time(i);
        time = t0:tstep:tf;
        deorbited = 1;
        break

    elseif (escaped == 0) % checks if the object reaches escape velocity
        if (norm(position(i,4:6)) >= sqrt(2 * G * M / radius(i)))
            escaped = 1;
        end

    end
end

%% ____________________
%% OUTPUTS

simulation = input('\nWould you like to generate a simulation? type 1 for yes, 0 for no --> ');
if (simulation)

    plotGroundTrack(x,z,radius,time,t0,tf); % plots the 2D groundtrack of object and its radius
    
    hold off
    
    plotPropagation(x,y,z,radius,time,t0,tf, gPos, access); % plots procedural propagation in 3D simulation
    
    close all
end

report = input('Would you like to write a state report to a xlsx file? type 1 for yes, 0 for no --> '); % asks the user if they want a state report
if (report)

    header = ["Time (sec)", "Altitude (km)", "x (km)", "y (km)", "z (km)"];
    
    writematrix(header,"stateReport.xlsx", "WriteMode", "overwrite");
    writematrix([time' (radius(1:length(time)) - R) x(1:length(time)) y(1:length(time)) z(1:length(time))],"stateReport.xlsx", WriteMode="append");

    writematrix("Properties:", "stateReport.xlsx", "Range", "F1:F1");
    writematrix("Deorbited","stateReport.xlsx", "Range", "F2:F2");
    writematrix("Escaped","stateReport.xlsx", "Range", "F3:F3");
    writematrix("Stable","stateReport.xlsx", "Range", "F4:F4");
    writematrix(["No"; "No"; "No"],"stateReport.xlsx", "Range", "G2:G4");

    if (deorbited == 1)
        writematrix("Yes","stateReport.xlsx", "Range", "G2:G2");
    elseif (escaped == 1)
        writematrix("Yes","stateReport.xlsx", "Range", "G3:G3");
    else
        writematrix("Yes","stateReport.xlsx", "Range", "G4:G4");

    end

    fprintf('\nA xlsx file containing a state report has been written to stateReport.xlsx\n')

else
    fprintf('\nProcess has ended\n')
end

%% ____________________
%% USER DEFINED FUNCTIONS
%% ____________________
%
% <include>universalConstants.m</include>
%
%% ____________________
%
% <include>inputRead.m</include>
%
%% ____________________
%
% <include>getDE.m</include>
%
%% ____________________
%
% <include>Satellite.m</include>
%
%% ____________________
%
% <include>plotGroundTrack.m</include>
%
%% ____________________
%
% <include>plotPropagation.m</include>
%

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.