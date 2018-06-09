function sendGcode(GCodeCell,PORT)
out = instrfind;
fclose(out);

cellSize = size(GCodeCell,1);

arduino = serial(PORT, 'BaudRate',115200);
set(arduino,'TimeOut',120);
fprintf('Initiating Arduino Serial Connection...')
fopen(arduino);
pause;

fscanf(arduino)
fscanf(arduino)
for n = 1:cellSize
    out = GCodeCell{n};
    if out(1) ~= '('
        fprintf(arduino,GCodeCell{n});
        confirm = fgetl(arduino);
        fprintf('%s \t %s',GCodeCell{n},confirm);
    end
end

fclose(arduino);