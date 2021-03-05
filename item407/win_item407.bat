@echo on
SETLOCAL
SET VCVARSBAT="C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat"
SET TOOLCHAIN=x64
call %VCVARSBAT% %TOOLCHAIN%
@echo on
CL.exe /nologo /guard:cf /W1 /WX- /sdl- /O2 /Oi /Oy- /D SQLITE_API=__declspec(dllexport) /D SQLITE_DEFAULT_FOREIGN_KEYS=1 /D SQLITE_ENABLE_COLUMN_METADATA /D SQLITE_ENABLE_FTS3_PARENTHESIS /D SQLITE_ENABLE_FTS4 /D SQLITE_ENABLE_FTS5 /D SQLITE_ENABLE_JSON1 /D SQLITE_ENABLE_RTREE /D SQLITE_OS_WIN /D SQLITE_WIN32_FILEMAPPING_API=1 /D NDEBUG /D _USRDLL /D _WINDLL /DEBUG:FULL /Gm- /EHsc /MT /GS /Gy /fp:precise /Zc:wchar_t /Zc:inline /Zc:forScope /Gd /TC /analyze- /I..\sqlite3\ /Fe.\item407.exe ..\sqlite3\sqlite3.c .\item407.c
ENDLOCAL
