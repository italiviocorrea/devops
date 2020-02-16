@echo off

set TMP_CLASSPATH=%CLASSPATH%


set CLASSPATH=%CLASSPATH%;.\classes\
rem Add all jars....
for %%i in ("lib\*.jar") do call "cpappend.bat" %%i

call "cpappend.bat" imagens
call "cpappend.bat" properties

set JAPPMODELER_CLASSPATH=%CLASSPATH%
set CLASSPATH=%TMP_CLASSPATH%

cls

java -cp "%JAPPMODELER_CLASSPATH%" -Xms256m -Xmx1024m org.jmycrudframework.jappmodeler.Main 
