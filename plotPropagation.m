function [] = plotPropagation(x,y,z,radius,time,t0,tf, gPos, access)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Function Call
% this function is called by main to get the main product of the program;
% an animated plot
%
% Input Arguments

% x, y, z // cartesian coordinate vectors of object
% radius // radius vector of object
% time // time frame for animation
% t0 // initial starting time
% tf // ending time of simulation

% Output Arguments
% the function uses animatedline to plot a 3D graph of the position of the
% satellite drawing a line as time progresses

% Function Decription
% The animated plot uses the product of all functions and simulations
% natural motion within the time frame given. It ends when time reaches 
% the given end or when the object hits the planet.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

universalConstants; % planet constants

figure('Name','Orbit Propagation');

%% ____________________
%% CALCULATIONS

[x1, y1, z1] = sphere; % coordinates of a sphere in cartesian

%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS

curve = animatedline('LineWidth',2);
set(gca,'XLim',[-1.5 1.5],'YLim',[-1.5 1.5],'ZLim',[-1.5 1.5]);
view(43,24);

hold on;

curve.Color = 'red';
curve.Visible = 'on';

surf(R * x1,R * y1,R * z1, 'Edgecolor', 'b'); % plot sphere with radius of planet
axis equal;
grid on;

curve.LineWidth = 1;

set(gca,'Color','k')
set(gcf,'color','k','units','normalized','outerposition',[0.5 0 0.5 1]);

title(sprintf('Spacecraft 1\nTime: %0.2f sec | Radius: %0.2f', time(1),radius(1)), 'Interpreter', 'latex','Color','w');

j_0 = int16((t0 / tf)*(length(time))) + 1; % stating time index (integer)

for j = j_0:length(time) % this foor loop generates the animated plot with position vectors with indexes
    addpoints(curve,x(j),y(j),z(j));
    head = scatter3(x(j),y(j),z(j),'filled','MarkerFaceColor','r');
    ground = scatter3(gPos(j,1),gPos(j,2),gPos(j,3),"filled","MarkerFaceColor","b");
    if(access(j))
        con = line([x(j), gPos(j,1)],[y(j), gPos(j,2)],[z(j), gPos(j,3)]);
    end
    drawnow
    pause(0.01);
    delete(head);
    delete(ground);
    if(access(j))
        delete(con);
    end

    title(sprintf('Spacecraft 1\nTime: %0.0f sec | Altitude: %0.2f km', time(j),radius(j) - R),'Interpreter','Latex','Color','w');

end

end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.