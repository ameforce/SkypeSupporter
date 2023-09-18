@ECHO OFF

set root=C:\Users\%USERNAME%\anaconda3
set proj_name=SkypeSupporter
set proj_main_name=skype
set exe_name=SkypeSupporter

echo | set /p="Trying to run conda..."
call %root%\Scripts\activate.bat %root%
echo Success !!

echo | set /p="Changing conda's environment..."
call conda activate %proj_name% 2> NUL

if errorlevel 1 (
  echo Failure
  echo The %proj_name% environment does not exist
  echo | set /p="Creating %proj_name% environment.."
  call conda create -n %proj_name% python=3.11 -y > NUL 2>&1
  echo | set /p="Creating %proj_name% environment..."
  call conda activate %proj_name%
)
echo Success !!

echo | set /p="Installing require python packages..."
call pip install -r requirements.txt > NUL
echo Success !!

echo | set /p="Shutting down the running %exe_name%.exe process..."
taskkill /f /im %exe_name%.exe > NUL 2>&1
echo Success !!

echo | set /p="Building %proj_main_name%.py to %exe_name%.exe..."
call pyinstaller -n "%exe_name%" --onefile --noconsole %proj_main_name%.py > NUL 2>&1
echo Success !!

echo | set /p="Moving %exe_name%.exe..."
call move "dist\%exe_name%.exe" ".\%exe_name%.exe"
echo Success !!

: echo | set /p="Running %exe_name%.exe..."
: start "" "ENM-Secretary.exe"
: echo Success !!


