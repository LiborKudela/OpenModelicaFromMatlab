function [res, des]=ImportOM_Results(file, regex, varargin);
%% using https://www.mathworks.com/matlabcentral/fileexchange/49015-modelicaimport
[res, des] = modelicaImport(file, regex, varargin);

end