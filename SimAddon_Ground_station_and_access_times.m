% Addon to current propagator to allow:
% 1) Creation of a moving ground station based on latitude and longitude
% 2) Determination of when the satellite is within view of the ground
% station
% 3) Notices when access is lost/aquired.

%% Constants and stuff
radE = 0.0; % radius of earth
t = 0; % time variable, units unknown
tDil = 0; % 2pi / 1 day in time unit used
sat = [0, 0, 0]; % TODO: find the satellite coords name and convert to cartesian if needed
Access = false;

%% Setup for the ground station
groundZ = radE * sin(input("Enter the ground station latitude: ") * pi / 180);
radG = sqrt(radE ^ 2 - groundZ ^ 2); % r^2 + z^2 = radE

% Computes time out of 2pi based on longitude for where the station starts
t = atan(input("Enter the ground station longitude: ") * pi / 180);
if(strcmp(input("E/W: ","s"),"W"))
    t = 360 - t;
end

% turns t from rad to whatever units t should be in
t = t / tDil;

%% All this goes inside the loop used for propagation

% Position of the ground station as a function of time
gPos = [cos(t * tDil) * radG, sin(t * tDil) * radG, groundZ];
Uout = gPos ./ norm(gPos); % Unit vector normal to the earth at gPos
gToS = sat - gPos / norm(sat - gPos); % Unit vector from earth to satellite
theta = acos(dot(Uout, gToS)); % Formula for angle between 2 unit vectors

% Logic block to determine when access starts and ends
if(theta > pi/ 2 && Access)
    disp("Access lost");
    Access = false;
    % Maybe throw something in here to log time to a spreadsheet
elseif(theta <= pi / 2 && ~Access)
    disp("Access aquired");
    Access = true;
    % Same thing here
end
