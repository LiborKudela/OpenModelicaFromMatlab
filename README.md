

# OpenModelicaFromMatlab
Tested on OpenModelica v1.13.0-dev-672-g87286cb84,  MD5SUM - c81dc4cd06acabead40ad7cb93417ec1

Build models, execute with flags, anylise results.
Using calls to OMC from Matlab.
Almost all OM scripting available in Matlab.

# Tutorial
Firstly we have to create OM_Script.m which is done by following Matlab command 
(run this always when update OpenModelica)

```
>> CreateOM_Script_class 
```

We create empty script

```
>> 1st_Script=OM_Script
```

You will probably always load Modelica standart library (notice single quotes => it is NOT a string !!!)

```
>> 1st_Script.loadModel('Modelica')
```

Load your package.mo file (notice double quotes => it is a string inside single quotes !!!)

```
>> 1st_Script.loadFile('"C:\..your path...\YourPackage.mo"')
```

Simulate your model which is inside YourPackage (notice single quotes => it is NOT a string !!!)

```
>> 1st_Script.simulate('YourPackage.YourModel')
```

All the above was wrinting a script. Let's make it Sript.mos and and let it run bz OpenModelica Compiler.
The argument in bracket is telling the cmd to run script without start (Wait) or with start (DoNotWait)

```
>> 1st_Script.Launch('Wait')
```

Simulation will drop result files into OMResult folder inside OpenModelicaFromMatlab folder.
You can access result by:

```
>> res=ImportOM_Results(string('OMResults\YourPackage.YourModel_res.mat'));
```

The res variable is struct with results. You can use dot notation to go through them.

```
>> plot(res.time,res.Component.Variable)
```

You can also use flags for compiler.
If you do not simulate model but only build the executeble by using:

'''
>> 1st_Script.build('YourPackage.YourModel')
'''

Then you can use folowing command to run the executable and use flags like overrides. For example:

```
>> RunBuiltOMModel([string('OMResults\YourPackage.YourModel.exe'),' -override stopTime=3,Component.Parameter1=5'],'Wait')
```
The res variable can be obtained in the same way as above.
You can write your own function which may run several executables at once.
You can run the same executable simultaniously several times each with different override.
You can write wrraper around RunBuiltOMMOdel which can assign overrides automaticaly, 
which is useful for lagre parametrical studies or Monte Carlo type simulations.


The proper use requires some reading:

The scripting commands (including the use of Debug and Compiler flags)
https://build.openmodelica.org/Documentation/OpenModelica.Scripting.html

The compiler flags
https://openmodelica.org/doc/OpenModelicaUsersGuide/latest/omchelptext.html

The simulation flags
https://openmodelica.org/doc/OpenModelicaUsersGuide/latest/simulationflags.html

This Matlab library is only a "wrraper" around those things.





