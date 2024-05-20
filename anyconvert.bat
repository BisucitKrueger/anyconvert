@echo off
setlocal enabledelayedexpansion

rem Prompt user for input directory
set /p "input_dir=Enter the input directory containing files to convert: "

rem Prompt user for output directory
set /p "output_dir=Enter the output directory where you want to save the converted files: "

rem Prompt user for desired output file extension
set /p "output_extension=Enter the desired output file extension (e.g., .mp4): "

rem Create the output directory if it doesn't exist
if not exist "%output_dir%" mkdir "%output_dir%"

rem Loop through all files in the input directory
for %%f in ("%input_dir%\*.*") do (
    set "filename=%%~nf"
    set "output_filename=!filename!!output_extension!"
    ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i "%%f" -c:v h264_nvenc -preset p2 "%output_dir%\!output_filename!"
)

echo Conversion complete!
pause
