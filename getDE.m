function [tout,a,stateout] = getDE(time, r, theta, xdot0, ydot0, zdot0, phi)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Function Call
% the function is called by main when it needs an array that describes the
% position function of the object
%
% Input Arguments

% time // array that contains beginning, end, and step of time span 
% r // initial radius of the object measured in km from center of earth
% theta // horizontal initial angle per spherical coordinates in radians
% xdot0 // initial velocity in the x direction (away from earth)
% phi // inclination of the initial orbit in radians

%
% Output Arguments

% a // semi-major axis of the elliptical orbit in km
% stateout // array of size 6x(timeSpan) contains the x, y, and z
% coordinates and each of its first derivatives with respect to time

% Function Description
% uses ode45 to solve a differential equations of position, velocity, and time
% with initial conditions. 

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%% ____________________
%% INITIALIZATION

universalConstants % Get Planet Parameters

% Initial Conditions cartesian

x0 = r * cos(theta) * sin(phi); % initial x coordinate
y0 = r * sin(theta) * sin(phi); % initial y coordinate
z0 = r * cos(phi);  % initial z coordinate

%% ____________________
%% CALCULATIONS

a = norm([x0; y0; z0]); % semi-major axis of elliptical shape

stateinitial = [x0; y0; z0; xdot0; ydot0; zdot0]; % matrix with initial position and velocity vectors

tspan = time; % independent variable of differential equation

%% ____________________
%% COMMAND WINDOW OUTPUT

vel_acc = @Satellite; % object force model function

opt = odeset('AbsTol', 1e-8, 'RelTol', 1e-8);
[tout, stateout] = ode45(vel_acc, tspan, stateinitial, opt); % built in integration of the equations of motion

end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.