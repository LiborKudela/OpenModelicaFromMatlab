function [ClassList,TypeList,ParameterList]=GET_OM_Classes_Info(IncludeModelica,PathString)
ModelName=char(regexp(PathString,'(?<=\\)[a-zA-Z0-9_]*(?=\.mo)','match'));
CreateOM_Script_class;
%---1st Script construction
OM=OM_Script;
OM.loadModel('Modelica');
OM.loadFile(['"',PathString,'"']);
OM.getClassNames([ModelName,',true,true,false,false,true,false']);%1
if IncludeModelica==true
OM.getClassNames('Modelica,true,true,false,false,true,false')%2
end
%---colecting results from 1st script
[~,ResultString]=OM.Launch('Wait');
ResultString=char(regexp(ResultString,'(?<=\{)[^}]*(?=\})','match'));
ClassList{1}=regexp(ResultString(1,:),',','split');%1
if IncludeModelica==true
ClassList{2}=regexp(ResultString(2,:),',','split');%2
ClassList=horzcat(ClassList{1},ClassList{2});
else
ClassList=horzcat(ClassList{1});
end
%---2nd Script construction
OM=OM_Script;
OM.loadModel('Modelica');
OM.loadFile(['"',PathString,'"']);
for i=1:length(ClassList)
OM.getParameterNames(ClassList{i});
end
%---colecting results from 2nd script
[~,ResultString]=OM.Launch('Wait');
ResultString=char(regexp(ResultString,'\{.*?\}','match'));
[NumOfModels,~]=size(ResultString);
for i=1:NumOfModels
ParameterList{i}=regexprep(ResultString(i,:),'"','''');
end
%---3rd Script construsction
OM=OM_Script;
OM.loadModel('Modelica');
OM.loadFile(['"',PathString,'"']);
for i=1:length(ClassList)
OM.getClassInformation(ClassList{i});
end
%---colecting results from 3rd script
[~,ResultString]=OM.Launch('Wait');
ResultString=char(regexp(ResultString,'\(.*?\)','match'));
for i=1:NumOfModels
TypeList{i}=regexp(ResultString(i,:),'(?<=")[^,].*?(?=")','once','match');
end

end
