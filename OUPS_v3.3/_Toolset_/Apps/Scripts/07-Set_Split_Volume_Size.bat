@echo off&&title %Name% ^| Setting Split Volume Size
for /f "tokens=1" %%a in ('%Apps%\du.exe --block-size=1M -c %Post%\%flnm%\ ^| findstr /R "^[0-9]"') do (set size=%%a)
set xize=%size%X
if "%xize:~1,1%"=="X"  (goto small_sizes)
if "%xize:~2,1%"=="X"  (goto small_sizes)
if "%xize:~3,1%"=="X"  (goto small_sizes)
if "%xize:~4,1%"=="X"  (goto small_sizes)
if "%xize:~5,1%"=="X"  (set size=%size:~0,2%000)
if "%xize:~6,1%"=="X"  (set size=%size:~0,3%000)
if "%xize:~7,1%"=="X"  (set size=%size:~0,4%000)
if "%xize:~8,1%"=="X"  (set size=%size:~0,5%000)
if "%xize:~9,1%"=="X"  (set size=%size:~0,6%000)
set /a vtmp=%size% / 10
set vol=%vtmp%m

:small_sizes
if %size% LSS 10000 (set vol=1000m)
if %size% LSS 5000  (set vol=500m)
if %size% LSS 2000  (set vol=200m)
if %size% LSS 1000  (set vol=100m)
if %size% LSS 500   (set vol=50m)
if %size% LSS 100   (set vol=10m)
:end_size_work