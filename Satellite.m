function dstatedt = Satellite(time, state)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Function Call
% the function is called by getDE to apply the force model of the
% spacecraft
%
% Input Arguments

% t // time frame
% state // matrix with values of position and initial velocity

% Function Description
% This function uses unit vectors to produce a vector of acceleration and 
% velocity at any time t.

% Output Arguments
% the function outputs a vector with initial velocty vector and initial
% acceleration vector [xdot xdotdot]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

%%%stateinitial = [x0;y0;z0;xdot0;ydot0;zdot0];

% inertia and mass
m = 2.6; %%kilograms

universalConstants

%% ____________________
%% CALCULATIONS

% kinematics
vel = state(4:6);

% gravity Model

r = state(1:3); % position vector
rnorm = norm(r); % radius vector
rhat = r/rnorm; % radius unit vector
Fgrav = -(G*M*m/rnorm^2)*rhat; % newton's law of gravitation

% dynamics
F = Fgrav; % force between planet and object
accel = F/m; % acceleration between planet and orbit

% return derivatives vector
dstatedt = [vel;accel]; % vector of velocity and acceleration

end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.