@echo off
@REM setlocal

rem Chemins
set "projectName=Ticketing"
set "projectPath=."
set "tempPath=temp"
set "tomcatPath=C:\Program Files\Apache Software Foundation\Tomcat 10.1\"

mkdir "%projectPath%\web\WEB-INF\"
mkdir "%tempPath%\WEB-INF\"

rem Supprimer le répertoire temporaire s'il existe déjà
if exist "%tempPath%" rmdir /s /q "%tempPath%"

echo Compilation...
rem Compiler le code source dans le dossier WEB-INF/classes
for /r ".\" %%i in (*.java) do xcopy "%%i" "%tempPath%\src\"
@REM javac -g -cp .;lib/* -d "%tempPath%\WEB-INF\classes" "%projectPath%\src\java\*.java"
javac -g -cp .;lib/* -d "%tempPath%\WEB-INF\classes" "%tempPath%\src\*.java"
echo Compilation finished.
echo.

echo Copying xml files...
xcopy "%projectPath%\src\dispatcher-servlet.xml" "%tempPath%\WEB-INF\" /i
xcopy "%projectPath%\src\web.xml" "%tempPath%\WEB-INF\" /i
echo Xml files copied successfuly.
echo.

rem Copier les librairies dans un fichier .war dans le répertoire temporaire
@REM cd "%projectPath%\lib"

echo Copying jsp files in views...
rem copier le répertoire views dans temp
xcopy "%projectPath%\src\views" "%tempPath%\views\" /i
xcopy "%projectPath%\index.jsp" "%tempPath%\" /i
xcopy "%projectPath%\error.jsp" "%tempPath%\views" /i
xcopy "%projectPath%\notfound.jsp" "%tempPath%\views" /i
xcopy "%projectPath%\indexFront.jsp" "%tempPath%\" /i
echo Jsp files copied successfuly. 
echo.

echo War generation...
xcopy "%projectPath%\lib" "%tempPath%\WEB-INF\lib" /i
jar cf "%tempPath%\%projectName%.war" .
echo War generated successfuly.
echo.

echo Repository in server in  preparation....
rem Supprimer l'ancienne version du projet dans Tomcat
rmdir /s /q "%tomcatPath%webapps\%projectName%"
rd /s /q "%tempPath%\src\"

@REM rem Copier le projet depuis le répertoire temporaire vers Tomcat
xcopy "%tempPath%\" "%tomcatPath%webapps\%projectName%" /s /e /i
@REM echo "%tomcatPath%webapps\nom_du_projet"

rem Effacer répertoire Temp et Web dans le dossier du projet
rd /s /q "%tempPath%"
rd /s /q "%projectPath%\web"

rem Arrêter Tomcat
cd "%tomcatPath%\bin"
@REM call shutdown.bat

@REM rem Redémarrer Tomcat
@REM Tomcat10

echo Repository is ready to be used.
echo.

echo Déploiement terminé.
pause

@REM timeout /t 20

@REM echo Ouverture microsoft edge...
@REM start msedge http://localhost:8888
@REM pause