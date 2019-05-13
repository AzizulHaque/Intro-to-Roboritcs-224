clear all
close all
clc


if ~isempty(instrfind)
     fclose(instrfind);
      delete(instrfind);
end

sl = seriallist;
for idx = 1:length(sl)
    sl{idx}
end
instrfind
instrfindall

aUno=serial('COM18','BaudRate',9600);

% initiate arduino communication
fopen(aUno); 

% % wait 5 seconds to give systemn chance to process request
pause(5);

disp("Swan!");


   
% Home Position
fprintf(aUno, "1,0n");
pause(1);
fprintf(aUno, "2,0n");
pause(1);
fprintf(aUno, "3,0n");
pause(1);
fprintf(aUno, "4,0n");
pause(1);

%H
fprintf(aUno, "1,150n");
pause(1);
fprintf(aUno, "2,32n");
pause(1);
fprintf(aUno, "3,10n");
pause(1);
fprintf(aUno, "1,160n");
pause(1);
fprintf(aUno, "6,110n");
pause(0.4);
fprintf(aUno, "6,0n");
pause(1);


fprintf(aUno, "1,50n");
pause(1);
fprintf(aUno, "2,50n");
pause(1);
fprintf(aUno, "3,50n");
pause(1);
fprintf(aUno, "4,50n");
pause(1);

fprintf(aUno, "1,0n");
pause(1);
fprintf(aUno, "2,0n");
pause(1);
fprintf(aUno, "3,0n");
pause(1);
fprintf(aUno, "4,0n");
pause(1);

% % wait 5 seconds
pause(5);


