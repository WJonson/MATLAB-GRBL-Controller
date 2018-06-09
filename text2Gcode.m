function Xmax = text2Gcode(fileName,xx,yy)
% TEXT2GCODE  Takes a file with Gcode and shifts its all of its coordinates
%   by 'xx' in the X and 'yy' in the Y directions.
%
%       Xmax = TEXT2GCODE(fileName, xx, yy)  Reads 'fileName', which is a
%       .txt. file, and shifts all of the coordinates by 'xx' in the X
%       direction and 'yy' in the Y direction. The function also outputs
%       the variable 'Xmax' which is used to determine where the next
%       letter should start.
%
%       **NOTE** This function is used only for the text plotter function
%       and uses the pre-created Gcode files for letters and numbers.
%
%       

cd('LetterGcode');
fid=fopen(fileName);
tline = fgetl(fid);
gcodeLines = cell(0,1);

%Turns the Gcode .txt file into a CELL
while ischar(tline)
    gcodeLines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);

gcodeSize = size(gcodeLines,1);
changeToolLine = false;
zeroString = [];

[Xmax,~,~,~]=findMinMax(fileName);      %Finds the X max value of the Gcode

%Shift all coordinates and create a new Gcode file
for n = 1:gcodeSize
    readLine = gcodeLines{n};
    %Ignores misc commands
    if ~isempty(readLine)
        lineSize = size(readLine,2);
        if readLine(1) == 'M' | readLine(1) == 'G21'...
                | readLine(1) == '%' | readLine(5) == 'Z' | lineSize <6
        elseif readLine(1) =='('
        %Only care about G00, G01, G02, and G03 commands
        elseif readLine(2:3) == '00' | readLine(2:3) == '01' | ...
                readLine(2:3) == '02' | readLine(2:3) == '03'
           %Find X, Y, and Z coordinates
           locateX = find(readLine == 'X');
           locateY = find(readLine == 'Y');
           locateZ = find(readLine == 'Z');
           %Check to see if there is a Z coordinate
           if isempty(locateZ)
               newYstring = readLine(locateY+1:end);
               locateZ = size(newYstring,2)+locateY+2;
           else
               newYstring = readLine(locateY+1:locateZ-2);
           end
           %Create new X and Y coordinates
            newXstring =readLine(locateX+1:locateY-2);
            newX = str2num(newXstring)+xx;
            newY = str2num(newYstring)+yy;
            newX =  round(newX,6,'significant') ;
            newY = round(newY,6,'significant');
            sendX = num2str(newX);  %New X coordinates of string type
            sendY = num2str(newY);  %New Y coordinates of string type
            sizeX = size(sendX,2);
            sizeY = size(sendY,2);
            %Variables to help create a new string file /w new coordinates
            %New X and Y must be of the same size of original coordinates
            diffX= ((locateY-1)-(locateX+1)) - sizeX; 
            diffY = ((locateZ-1)-(locateY+1)) - sizeY;
           if diffX > 0
                for h = 1:diffX
                    zeroString = [zeroString,'0'];
                end
                readLine(locateX+1:locateY-2) = [sendX zeroString];
                gcodeLines{n} = readLine;
                zeroString = [];
           elseif diffX == 0
               readLine(locateX+1:locateY-2) = sendX;
               gcodeLines{n} = readLine;
           end
            if diffY > 0
                for h = 1:diffY
                    zeroString = [zeroString,'0'];
                end
                readLine(locateY+1:locateZ-2) = [sendY zeroString]; 
                gcodeLines{n} = readLine;
                zeroString = [];
           elseif diffY == 0
               readLine(locateY+1:locateZ-2) = sendY;
               gcodeLines{n} = readLine;
            end 
        end
    end
end


cd ..                       %Go back to previous directory
%Create new Gcode .txt file with shifted Gcode
%**NOTE** this will not delete any previous files named 'gcode_TEXT.txt'
%   it will only add on to the end of the current file.
%If you want to start fresh you need to delete past file.
for n=1:gcodeSize
    out = gcodeLines{n};
    u = sprintf(out);
    fid = fopen('gcode_TEXT.txt','a');
    fprintf(fid,'%c',u);
    fprintf(fid,'\n');
end
fclose('all');
