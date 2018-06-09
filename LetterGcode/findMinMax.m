function [Xmax,Ymax] = findMinMax(fileName)
format long
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
X=[];
Y=[];
for n = 1:gcodeSize
    readLine = gcodeLines{n};
    if ~isempty(readLine)
        lineSize = size(readLine,2);
        if readLine(1) == 'M' | readLine(1) == 'G21'...
                | readLine(1) == '%' | readLine(5) == 'Z' | lineSize <6 ...
            | readLine(2) == '4'
        elseif readLine(1) =='('
        elseif readLine(2:3) == '00' | readLine(2:3) == '01' | ...
                readLine(2:3) == '02' | readLine(2:3) == '03'
           locateX = find(readLine == 'X');
           locateY = find(readLine == 'Y');
           locateZ = find(readLine == 'Z');
           if isempty(locateZ)
               newYstring = readLine(locateY+1:end);
               locateZ = size(newYstring,2)+locateY;
           else
               newYstring = readLine(locateY+1:locateZ-2);
           end
            newXstring =readLine(locateX+1:locateY-2);
            newX = str2double(newXstring);
            newY = str2double(newYstring);
            X =  [X round(newX,6,'decimals')];
            Y = [Y round(newY,6,'decimals')];
        end
    end
end

Xmax = max(X);
Ymax = max(Y);