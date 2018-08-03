function [status,ResultString]=RunBuiltOMModel(execute_string,start)

if string(start)=="Wait"
command=['C:',' && ','cd ','%OPENMODELICAHOME%bin',' && ',execute_string];
elseif  string(start)=="DoNotWait"
command=['C:',' && ','cd ','%OPENMODELICAHOME%bin',' && start ',execute_string]; 
end
disp(['System :',command]);
[status,ResultString]=system(command);

end