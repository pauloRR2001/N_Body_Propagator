function [access] = accessCheck(gPos, position)
% Checks if the satellite has access to the ground station

if(size(gPos) ~= size(position))
    disp("Huston, we have a problem");
end

access = zeros(1, length(gPos)); % Pre-allocation of space for access

i = 1;
for n = 1:length(gPos)
    Uout = gPos(i,:) ./ norm(gPos(i,:)); % Unit vector normal to the earth at gPos
    gToS = (position(i,1:3) - gPos(i,:)) ./ norm(position(i,1:3) - gPos(i,:)); % Unit vector from earth to satellite
    theta = acos(dot(Uout, gToS)); % Formula for angle between 2 unit vectors
    access(1, i) = (theta <= pi / 2);
    i = i + 1;
end

end