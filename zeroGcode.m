function zeroGcode(fileName,NewName)
% ZEROGCODE  Takes a Gcode file and shifts it to the orgin.
%
%       ZEROGCODE(fileName, NewName)  finds the minimum value of the X and
%       Y from the orginal Gcode and subtracts that value from all the
%       coordinates. This will have both the X and Y axes serve as minimum
%       limits for the Gcode. The new Gcode will also have a new name
%       determined by 'NewName'.
%
%       This helps shift the Gcode later to any position we want.
%
%       **NOTE** This function works with the pre-crearted Gcode that was
%       created for the letters.
%

fid=fopen(fileName);
tline = fgetl(fid);
gcodeLines = cell(0,1);
while ischar(tline)
    gcodeLines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);

gcodeSize = size(gcodeLines,1);
changeToolLine = false;
zeroString = [];

[~,~,xx, yy] = findMinMax(fileName)     %Find min values for X and Y

%Scan through the Gcode and shift all coordinates
for n = 1:gcodeSize
    readLine = gcodeLines{n};
    %Ignore misc commands
    if ~isempty(readLine)
        lineSize = size(readLine,2);
        if readLine(1) == 'M' | readLine(1) == 'G21'...
                | readLine(1) == '%' | readLine(5) == 'Z' | lineSize <6
        elseif readLine(1) =='('
        %Only care about G00, G01, G02, and G03 commands
        elseif readLine(2:3) == '00' | readLine(2:3) == '01' | ...
                readLine(2:3) == '02' | readLine(2:3) == '03'
           %Find the coordinates
           locateX = find(readLine == 'X');
           locateY = find(readLine == 'Y');
           locateZ = find(readLine == 'Z');
           %Check if there is a Z coordinate
           if isempty(locateZ)
               newYstring = readLine(locateY+1:end);
               locateZ = size(newYstring,2)+locateY;
           else
               newYstring = readLine(locateY+1:locateZ-2);
           end
            %Save new shifted coordinates
            newXstring =readLine(locateX+1:locateY-2);
            newX = str2num(newXstring)-xx;
            newY = str2num(newYstring)-yy;
            newX =  round(newX,6,'significant') ;
            newY = round(newY,6,'significant');
            sendX = num2str(newX); %New X in string form
            sendY = num2str(newY); %New Y in string form
            sizeX = size(sendX,2);
            sizeY = size(sendY,2);
            %New coordinates must be of the same size as oringals
            %The following functions check for this and fills '0' if not
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

cd('LetterGcode');
%Save new .txt file containg new Gcode
for n=1:gcodeSize
    out = gcodeLines{n};
    u = sprintf(out);
    fid = fopen(NewName,'a');
    fprintf(fid,'%c',u);
    fprintf(fid,'\n');
end
fclose('all');
cd ..
 