@echo off
set GAME=ToyMania
set PASSWORD=GreatCollector

set WIN_SOURCE=..\releases\windows\ToyMania_windows_portable_password_is_GreatCollector\tm

echo.
echo Building Windows portable 7z archive...
echo.

"C:\Program Files\7-Zip\7z.exe" a -t7z "%GAME%_windows_portable_password_is_%PASSWORD%.7z" "%WIN_SOURCE%" -mx=9 -m0=LZMA2 -md=64m -mfb=64 -ms=on -mmt=12 -p%PASSWORD% -mhe=on

echo.
echo Windows portable build complete.
pause
