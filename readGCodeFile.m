function gcodeLines = readGCodeFile(fileName)
% READGCODEFILE  Takes a Gcode text file and turns it into a CELL.
%
%       gcodeLines = READGCODEFILE(fileName)  outputs a CELL matrix
%       containg the contents inside of 'fileName.' 'fileName' should be a
%       .txt file containing Gcode.
%

fid=fopen(fileName);
tline = fgetl(fid);
gcodeLines = cell(0,1);
while ischar(tline)
    gcodeLines{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
