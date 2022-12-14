@rem taskarg: ${file}
@Echo off
set OLDHOME_FOLDER=%~dp0
set PATH_GRAPHVIZ="C:\Program Files\Graphviz\bin\dot.exe"
pushd %OLDHOME_FOLDER%
call ..\.venv\Scripts\activate
rem ---------------------------------------------------
set _date=%DATE:/=-%
set _time=%TIME::=%
set _time=%_time: =0%
rem ---------------------------------------------------
rem ---------------------------------------------------
set _decades=%_date:~-2%
set _years=%_date:~-4%
set _months=%_date:~3,2%
set _days=%_date:~0,2%
rem ---------------------------------------------------
set _hours=%_time:~0,2%
set _minutes=%_time:~2,2%
set _seconds=%_time:~4,2%
rem ---------------------------------------------------


set INPATH=%~dp1
set INFILE=%~nx1
set INFILEBASE=%~n1

set INPATH=%~dp1
set INFILE=%~nx1
set INFILEBASE=%~n1
set _INEXTENSION=%~x1
SET INEXTENSION=%_INEXTENSION:~1%
SET CLEANED_FILE_NAME=%INFILEBASE%_%INEXTENSION%

set BASE_OUTPUT_FOLDER=%OLDHOME_FOLDER%reports
set SUB_OUTPUT_FOLDER=%BASE_OUTPUT_FOLDER%\%CLEANED_FILE_NAME%\graph_profiling
SET OUTPUT_FILE=%SUB_OUTPUT_FOLDER%\[%_years%-%_months%-%_days%_%_hours%-%_minutes%-%_seconds%]_%INFILEBASE%.svg


SET CONVERT_SCRIPT_PATH=%OLDHOME_FOLDER%svg_to_png.py



pushd %INPATH%
python -m cProfile -o %INFILEBASE%_graph.pstats %INFILE%


MKDIR %SUB_OUTPUT_FOLDER%
call gprof2dot.exe -f pstats -e 0.05 -n 0.05 %INFILEBASE%_graph.pstats | %PATH_GRAPHVIZ% -Tsvg -o %OUTPUT_FILE%
DEL %INFILEBASE%_graph.pstats
call %CONVERT_SCRIPT_PATH% %OUTPUT_FILE%
echo finished
pushd %OLDHOME_FOLDER%
