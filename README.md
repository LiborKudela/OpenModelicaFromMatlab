# OpenModelicaFromMatlab
Tested on OpenModelica v1.13.0-dev-672-g87286cb84,  MD5SUM - c81dc4cd06acabead40ad7cb93417ec1

Build models, execute with flags, anylise results.
Using calls to OMC from Matlab.
Almost all OM scripting available in Matlab.
Hints using TAB in Matlab.

# Example
```
clc
clear all
close all
build=false;

%% Build executable
if build
OM=OM_Script;
OM.loadModel('Modelica');OM.getErrorString('');
OM.loadFile('"C:\...\Modelica\Package.mo"');OM.getErrorString('');
OM.buildModel('Package.TESTS.TEST_STAR');OM.getErrorString('');
[~,Build]=OM.Launch('Wait')
end

%% paths to built stuff and result file to be created

%execute this
path_exe='C:\...\OMResults\Package.TESTS.TEST_STAR.exe';

%input stuff are in this folder
path_input='C:\...\OMResults';

%make result file here
path_result=['C:\...\OMResults\Package.TESTS.TEST_STAR_res.mat'];

%% override these stuff when executing .exe
OVR{1}=['environment.SomeBoolVariable=','true'];
OVR{2}=['SomeComponent.SomeOfItsParameter=','1'];

% make it into one string
override=join(OVR,', ')

%% Run the executable with all flags (this will be made nicer into function nicer function call in future)
[~,Run]=RunBuiltOMModel([path_exe,' -inputPath=',path_input,' -r ',result_file,' -override ',override, ' -cpu'],'Wait')

% Translate .mat into struct (using https://www.mathworks.com/matlabcentral/fileexchange/49015-modelicaimport)
res = modelicaImport(string(path_result));

% drop time it took to run the .exe 
cpuTime=res.cpuTime(end)

% do some ploting here
%.plot(res.time,res.component.variable)
%. etc.
%.
```

