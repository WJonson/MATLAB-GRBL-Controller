function G02plotCircle(r,Xc,Yc)
% G02PLOTCIRCLE  Plots a circle of radius 'r' centered and 'Xc' and 'Yc'
%   coordinates.
%
%       G02PLOTCIRCLE(r, Xc, Yc) draws a circle of specified dimensions and
%       location. The inputed specifications should be in milimeters. While
%       the function does not output a variable, a .txt file is created
%       with the created Gcode. THe code creates a circle by drawing two
%       half-circles (top and bottom).
%

gcode = [];
%Parameters for first half-circle (Top)
Xs1 = Xc - r;                           %X coordinate start location (CW)
Ys1 = Yc;                               %Y coordinate start location (CW)
Xe1 = Xc + r;                           %X coordinate end location
Ye1 = Yc;                               %Y coordinate end location
%Angle is relative to Xc and Yc. Think of 4-quad grid with Xc and Yc orgin
Theta1_1 = 180;                         %Angle at X coordinate start 
Theta2_1 = 0;                           %Angle at X coordinate end

I1 = (Xc -(r*cosd(Theta1_1))) - Xc;     %Parameters for G02 and G03 commands
J1 = (Yc - (r*sind(Theta1_1))) - Yc;

%Parameters for second half-circle (Bottom)
Xs2 = Xc + r;
Ys2 = Yc;
Xe2 = Xc - r;
Ye2 = Yc;
Theta1_2 = 0;
Theta2_2 = 180;

I2 = (Xc -(r*cosd(Theta1_2))) - Xc;
J2 = (Yc - (r*sind(Theta1_2))) - Yc;

%Create Gcode for a circle
gcode=['F1000','\n'];                  %Set feed rate to 1000
gcode=[gcode,'M3 S90','\n'];           %Pen up command
gcode=[gcode,'G4 P1','\n'];
gcode=[gcode,'G21','\n'];              %units = mm

gcode=[gcode,'G000 X0.000 Y0.000','\n'];
gcode=[gcode,'G00',' X',num2str(Xs1, '%.3f\n'),' Y',num2str(Ys1,...
    '%.3f\n'),'\n'];

gcode=[gcode,'M5','\n'];
gcode=[gcode,'G4 P1','\n'];

gcode=[gcode,'G02',' X',num2str(Xe1, '%.3f\n'),' Y',num2str(Ye1,...
    '%.3f\n'),' I',num2str(I1, '%.3f\n'),' J',num2str(J1, '%.3f\n') ,'\n'];

gcode=[gcode,'G02',' X',num2str(Xe2, '%.3f\n'),' Y',num2str(Ye2,...
    '%.3f\n'),' I',num2str(I2, '%.3f\n'),' J',num2str(J2, '%.3f\n') ,'\n'];

gcode=[gcode,'M3','\n'];
gcode=[gcode,'G4 P1','\n'];
gcode=[gcode,'G000 X0.000 Y0.000','\n'];
                                                                
gcode=[gcode,'M30','\n'];           %End program command

u=sprintf(gcode);                   %Print Gcode into a string varaible

fid = fopen('gcode_G02circle.txt','w'); %Save to a .txt file
fprintf(fid,'%c',u);
fclose(fid);
