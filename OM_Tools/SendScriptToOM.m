function [result,str]=SendScriptToOM(Script)
[~,path]=system(['ECHO ','%OPENMODELICAHOME%bin']);path=path(1:end-1);addpath(path);
ScriptID=fopen([path,'\TEMPscript.mos'],'w');
fprintf(ScriptID,'%s\n',Script);
fclose('all');
[result,str]=system([path,'\omc ',[path,'\TEMPscript.mos']]);
end