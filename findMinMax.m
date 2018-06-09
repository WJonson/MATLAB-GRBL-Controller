function [Xmax,Ymax, Xmin, Ymin] = findMinMax(fileName)
% FINDMINMAX  Reads the Gcode file specified and determines what are the
%   maximum and minimum X and Y coordinates.
%
%       [Xmax, Ymax] = FINDMINMAX(fileName)  where "fileName' is a Gcode
%           text file, will scan through the Gcode and identify the 
%           max and min values for X and Y. The scan will only operate on
%           G00, G01, G02, and G03 commands and will skip any other 
%           line of text that does not begin with those commands.
%
%       The main purpose of this code was to find the MIN and MAX values 
%       so to shift the LETTER GCODE files that were pre-created. The MIN
%       values are used to shift the letters to the orgin and the MAX
%       values are used to properly space subsequent letters.
%

format long
fid=fopen(fileName);
tline = fgetl(fid);
gcodeLines = cell(0,1);
%Turns Gcode txt file into a CELL
while ischar(tline)
    gcodeLines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);

gcodeSize = size(gcodeLines,1);
changeToolLine = false;
zeroString = [];
X=[];
Y=[];

%Scan through Gcode
for n = 1:gcodeSize
    readLine = gcodeLines{n};
    %Following IF statement finds the commands we need and skips ones we
    %dont.
    if ~isempty(readLine)
        lineSize = size(readLine,2);
        %Misc commands we do not care about
        if readLine(1) == 'M' | readLine(1) == 'G21'...
                | readLine(1) == '%' | readLine(5) == 'Z' | lineSize <6
        elseif readLine(1) =='('
        %Checks to see if lines have the commands we care about
        elseif readLine(2:3) == '00' | readLine(2:3) == '01' | ...
                readLine(2:3) == '02' | readLine(2:3) == '03'
           %Finds the X, Y, and Z values locations
           locateX = find(readLine == 'X');
           locateY = find(readLine == 'Y');
           locateZ = find(readLine == 'Z');
           %Checks to see if there is a Z coordinate and saves coordinate
           if isempty(locateZ)
               newYstring = readLine(locateY+1:end);
               locateZ = size(newYstring,2)+locateY;
           else
               newYstring = readLine(locateY+1:locateZ-2);
           end
            newXstring =readLine(locateX+1:locateY-2);
            %Turns strings into doubles
            newX = str2double(newXstring);
            newY = str2double(newYstring);
            %Only care about X and Y. Save all X and Y into a vector
            X =  [X round(newX,6,'decimals')];
            Y = [Y round(newY,6,'decimals')];
        end
    end
end

%Finds the min and max values for X and Y
Xmin = min(X);
Ymin = min(Y);
Xmax = max(X);
Ymax = max(Y);
