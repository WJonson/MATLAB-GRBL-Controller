function plotSquare(Xs,Ys, Length)
%PLOTSQUARE  Plots a square with sides of length 'Length' that starts 
%   drawing at 'Xs' and 'Ys'.
%
%       PLOTSQUARE(Xs, Ys, Length)  Creates Gcode to draw a square of
%       specified length and starting point. The parameters entered should
%       all be in milimeters (mm). 'Xs' and 'Ys' determine the position of
%       the bottom-left corner of the square. This is where the Gcode will
%       begin drawing and also its drawing. There is no variable output but
%       a .txt file will be created containg the generated Gcode.
%
%       **NOTE** The Gcode in this file uses "Relative Positioning."
%       Meaning that the X and Y values are NOT coordinates and are instead
%       values to be added to the previous coordinate. 
%

gcode = [];

sides = double(Xs + Length);      %Determine the sides length relative to
                                  %the start positions.
Xs = double(Xs);
Ys = double(Ys);

%Generate Gcode 
gcode=['F1000','\n'];             %Feedrate at 1000
gcode=[gcode,'M3 S90','\n'];      %Pen up command
gcode=[gcode,'G4 P1','\n'];
gcode=[gcode,'G21','\n'];         %units = mm

gcode=[gcode,'G00',' X',num2str(Xs, '%.3f\n'),' Y',num2str(Ys,...
    '%.3f\n'),'\n'];

gcode=[gcode,'M5','\n'];          %Pen down command
gcode=[gcode,'G4 P1','\n'];

gcode=[gcode,'G01',' X',num2str(sides, '%.3f\n'),'\n'];
gcode=[gcode,'G01',' Y',num2str(sides, '%.3f\n'),'\n'];
gcode=[gcode,'G01',' X',num2str(Xs, '%.3f\n'),'\n'];
gcode=[gcode,'G01',' Y',num2str(Ys, '%.3f\n'),'\n'];

gcode=[gcode,'M3','\n'];
gcode=[gcode,'G4 P1','\n'];
gcode=[gcode,'G000 X0.000 Y0.000','\n'];    %Return-to-zero
                                                                
gcode=[gcode,'M30','\n'];                   %End program command

u=sprintf(gcode);                           %Create string variable

fid = fopen('gcode_Square.txt','w');        %Save to .txt file
fprintf(fid,'%c',u);
fclose(fid);
