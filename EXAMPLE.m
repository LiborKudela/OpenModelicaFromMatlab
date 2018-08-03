clc
clear all
close all

% add path and subfolders of OpenModelicaFromMatlab
% make it pwd !!!

% then run this in Command Window of Matlab (only once)
CreateOM_Script_class

% It asks the Windows for system path variable where OM lives
% and returns file OM_Script.m which is class containig available scripting methods
% It gains them from OMC so it should be compatible with your current OM version
% It was tested on:
% OpenModelica v1.13.0-dev-672-g87286cb84, MD5SUM - c81dc4cd06acabead40ad7cb93417ec1
% You probably want to have at least this version of OM to make it work !!!

% !!! A FILE "OM_Script.m" SHOULD EMERGE AT THE TOP LEVEL OF PWD (if not something is wrong)!!! 

%% Example of use:

% Create empty script
OM=OM_Sript

% Load standart Modelica library
OM.loadModel('Modelica');OM.getErrorString('');

% Load your Package
OM.loadFile('"C:\..your path...\YourPackage.mo"');OM.getErrorString('');

% build model (files will be droped to OMResults)
OM.buildModel('YourPackage.YourSubPackage.YourModel');OM.getErrorString('');

% or simulate with (files will be droped to OMResults)
% OM.simulate('YourPackage.YourSubPackage.YourModel');OM.getErrorString('');

% call OMC through system's CMD and let run the OM script (catch stdout to
% variable "Build") and wait till finished 
%('DoNotWait' calls it with "start" so it will not wait and it will not drop OMC stdout to Build)
[~,Build]=OM.Launch('Wait')

% path to built model executable
path_exe='C:\.. path to ..\OMResults\YourPackage.YourSubPackage.YourModel.exe';
% path to result file
path_result='C:\.. path to ..\OMResults\YourPackage.YourSubPackage.YourModel_res.mat';

% Simulate model (here you use overrides and so on, no build proccess - > fast simulation) 
% Stdout stored in Run variable (again works with 'Wait' only!!!)
[~,Run]=RunBuiltOMModel([path_exe,' -r ',result_file],'Wait')

% make result file to struct
res = modelicaImport(string(path_result));

% do some stuff with data here (for example plot them)
plot(res.time,res.Component.ItsVariable)








