@echo off

rem =====
rem For more information on ScriptTiger and more ScriptTiger scripts visit the following URL:
rem https://scripttiger.github.io/
rem Or visit the following URL for the latest information on this ScriptTiger script:
rem https://github.com/ScriptTiger/Repo-Search
rem =====

rem =====
rem Remember current directory for file output
rem =====

set DIR=%~dp0

rem =====
rem Change the current directory to the source directory to search
rem =====

if "%~1"=="" (
set /p INPUT=Root directory to search? 
) else (
set INPUT=%~1)
cd "%INPUT%"

rem =====
rem File types to search for
rem =====

if "%~2"=="" (
set /p TYPES=Search which source files ^(i.e. "*.txt *.md" to search all txt and md files^)? 
) else (
set TYPES=%~2)

rem =====
rem Begin main script
rem =====

:0

rem =====
rem Set options for search and execute
rem =====

choice /m "Use regular expressions?"
if %ERRORLEVEL%==1 (set FIND=findstr /r /s /i ) else (set FIND=findstr /s /i /c:)
set /p INPUT=Search for: || exit /b
set FIND=%FIND%"%INPUT%" %TYPES%^|more
%FIND%

rem =====
rem Give option to output search results to a file in the current directory
rem =====

choice /m "Output results to file?"
if %ERRORLEVEL%==1 (
set /p INPUT=Name of file to export results to? && %FIND%>"%DIR%%INPUT%.txt"
)

rem =====
rem Give option to open any source files of interest
rem =====

:1
set /P INPUT=Open file: || goto 0
write "%INPUT%"
goto 1