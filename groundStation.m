function [gPos] = groundStation(time, gSet, groundZ, radG)
% Creates a list of points representing the location of the ground station
% based on the time vector, the height of the station, its latitudial
% radius, and the offset at t = 0

tDil = 2 * pi / 86400; % Time scaling factor is 2pi / seconds in a day

gPos = zeros(length(time), 3); % Pre-allocation of memory to gPos

i = 1;
for t = time
    gPos(i,:) = [cos(t * tDil + gSet) * radG, sin(t * tDil + gSet) * radG, groundZ];
    i = i + 1;
end

end