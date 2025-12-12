@echo off
SETLOCAL

set DIRNAME=%~dp0
if "%DIRNAME%"=="" set DIRNAME=.
set APP_BASE_NAME=%~n0

rem locate java
if defined JAVA_HOME (
  if exist "%JAVA_HOME%\bin\java.exe" (
    set JAVA_EXE=%JAVA_HOME%\bin\java.exe
  ) else (
    set JAVA_EXE=java
  )
) else (
  set JAVA_EXE=java
)

"%JAVA_EXE%" -cp "%DIRNAME%gradle\wrapper\gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain %*
ENDLOCAL
