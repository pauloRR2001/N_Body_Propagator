function [theta, phi, altitude, vel0, bounds, m, lat, lon, dir] = inputRead()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Function Call
% the function is called at the beginning of main to have the user input
% initial conditions
%
% Input Arguments
% no inputs
%
% Output Arguments

% theta // horizontal angle by spherical coordinates convention
% phi // angle from the positive z axis by spherical coordinates convention
% altitude // altitude over surface of earth
% vel0 // x y z vector of initial velocities
% bounds // vector that contains starting time, step, and ending time of
% timeline
% m // mass of the object

% Function Description
% Takes care of receiving the input arguments, and validates their format 
% in case the user inputs an unwanted value such as a negative length or
% a vector with improper number of elements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% COMMAND WINDOW OUTPUT

theta = input("Input theta in radians --> "); % horizontal spherical coordinate angle

phi = input("Input phi in radians measured from the positive Z axis --> "); % vertical spherical coordinate angle

altitude = input("Input altitude over surface of the planet in km --> "); % altitude over surface of planet

while (altitude <= 0) % input validation of altitude
    fprintf("\nError: Altitude must be a positive value!\n\n")
    altitude = input("Input altitude over surface of the planet in km --> ");
end

m = input("Input mass of the object in kg --> "); % mass of the object in orbit

while (m <= 0) % validation of mass of the object
    fprintf("\nError: Mass must be a positive value!\n\n")
    m = input("Input mass of the object in kg --> ");
end

vel0 = input("Input initial velocity vector of the object in the format [vx0 vy0 vz0] km/s --> "); % initial velocity vector
while (length(vel0) ~= 3)
    fprintf("\nError: Velocity must be a 3-element row vector\n\n")
    vel0 = input("Input initial velocity vector of the object in the format [vx0 vy0 vz0] --> ");
end


bounds = input("Input the time frame desired as a vector in the format [t0 step tf] --> "); % time frame vector
while (length(bounds) ~= 3 || bounds(1) < 0 || bounds(2) <= 0 || bounds(3) <= 0 || bounds(1) > bounds(3)) % validation of time frame
    fprintf("\nError: Time frame must be a 3-element row vector of values greater than/equal to zero and t0 must be less than tf\n\n")
    bounds = input("Input the time frame desired as a vector in the format [t0 step tf] --> ");
end

%% Setup for the ground station - Ground station addon
lat = input("Enter the ground station latitude: ") * pi / 180;
lon = input("Enter the ground station longitude: ") * pi / 180;
dir = input("E/W: ","s");
    if(strcmp(dir,"W") == 0)
        dir = -1;
    else
        dir = 1;
    end
end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.