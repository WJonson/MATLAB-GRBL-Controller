function writeText(str,Xstart,Ystart)
% WRITETEXT  Takes a string variable and creates Gcode that will print the
% text starting at 'Xstart' and 'Ystart'.
%
%       WRITETEXT(str, Xstart, Ystart)   'Xstart' and 'Ystart' must be in
%       milimeters (mm) and str must be a string variable. A LUT will
%       determine what characters are in 'str' and pull up the
%       cooresponding Gcode for the character. TEXT2GCODE will then shift
%       the Gcode of that character to the appropriate location.
%
%       'str' can only contain characters 'A-Z' (only capitals), '0-9', and
%       '!','@','#','%'and '?'. 'str' can also contain spaces. 
%
%        **NOTE** This code does not output any .txt files and variables
%        directly. See TEXT2GCODE to see how 'gcode_TEXT.txt' is outputted.

strSize = size(str,2);
delete 'gcode_TEXT.txt';            %Clear any previous file

%Scan through 'str' and generate the Gcode .txt file
for n = 1:strSize
    if str(n) == 'A'
        %Previous characters ending position
        oldStart = Xstart;
        %Adds small space between letters so they are not bunched up
        Xstart = text2Gcode('Agcode.txt',Xstart,Ystart)+ oldStart + 1;
    elseif str(n) == 'B'
        oldStart = Xstart;
        Xstart = text2Gcode('Bgcode.txt',Xstart,Ystart)+ oldStart + 1;
    elseif str(n) == 'C'
        oldStart = Xstart;
        Xstart = text2Gcode('Cgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'D'
        oldStart = Xstart;
        Xstart = text2Gcode('Dgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'E'
        oldStart = Xstart;
        Xstart = text2Gcode('Egcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'F'
        oldStart = Xstart;
        Xstart = text2Gcode('Fgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'G'
        oldStart = Xstart;
        Xstart = text2Gcode('Ggcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'H'
        oldStart = Xstart;
        Xstart = text2Gcode('Hgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'I'
        oldStart = Xstart;
        Xstart = text2Gcode('Igcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'J'
        oldStart = Xstart;
        Xstart = text2Gcode('Jgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'K'
        oldStart = Xstart;
        Xstart = text2Gcode('Kgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'L'
        oldStart = Xstart;
        Xstart = text2Gcode('Lgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'M'
        oldStart = Xstart;
        Xstart = text2Gcode('Mgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'N'
        oldStart = Xstart;
        Xstart = text2Gcode('Ngcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'O'
        oldStart = Xstart;
        Xstart = text2Gcode('Ogcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'P'
        oldStart = Xstart;
        Xstart = text2Gcode('Pgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'Q'
        oldStart = Xstart;
        Xstart = text2Gcode('Qgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'R'
        oldStart = Xstart;
        Xstart = text2Gcode('Rgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'S'
        oldStart = Xstart;
        Xstart = text2Gcode('Sgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'T'
        oldStart = Xstart;
        Xstart = text2Gcode('Tgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'U'
        oldStart = Xstart;
        Xstart = text2Gcode('Ugcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'V'
        oldStart = Xstart;
        Xstart = text2Gcode('Vgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'W'
        oldStart = Xstart;
        Xstart = text2Gcode('Wgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'X'
        oldStart = Xstart;
        Xstart = text2Gcode('Xgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'Y'
        oldStart = Xstart;
        Xstart = text2Gcode('Ygcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == 'Z'
        oldStart = Xstart;
        Xstart = text2Gcode('Zgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '0'
        oldStart = Xstart;
        Xstart = text2Gcode('0gcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '1'
        oldStart = Xstart;
        Xstart = text2Gcode('1gcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '2'
        oldStart = Xstart;
        Xstart = text2Gcode('2gcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '3'
        oldStart = Xstart;
        Xstart = text2Gcode('3gcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '4'
        oldStart = Xstart;
        Xstart = text2Gcode('4gcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '5'
        oldStart = Xstart;
        Xstart = text2Gcode('5gcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '6'
        oldStart = Xstart;
        Xstart = text2Gcode('6gcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '7'
        oldStart = Xstart;
        Xstart = text2Gcode('7gcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '8'
        oldStart = Xstart;
        Xstart = text2Gcode('8gcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '9'
        oldStart = Xstart;
        Xstart = text2Gcode('9gcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '!'
        oldStart = Xstart;
        Xstart = text2Gcode('EXgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '#'
        oldStart = Xstart;
        Xstart = text2Gcode('Hashgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '@'
        oldStart = Xstart;
        Xstart = text2Gcode('ATgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '%'
        oldStart = Xstart;
        Xstart = text2Gcode('Pergcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == '?'
        oldStart = Xstart;
        Xstart = text2Gcode('Questgcode.txt',Xstart,Ystart)+ oldStart+ 1;
    elseif str(n) == ' '
        Xstart = Xstart + 5;
        out = ['G00 X',num2str(Xstart, '%.3f\n'),' Y',num2str(Ystart,...
    '%.3f\n')];
        u = sprintf(out);
        fid = fopen('gcode_TEXT.txt','a');
        fprintf(fid,'%c',u);
        fprintf(fid,'\n');
    end
end
        