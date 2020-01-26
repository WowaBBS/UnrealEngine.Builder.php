
set ltime=%time%
set /a hours=%ltime:~0,2%-%ftime:~0,2%
set /a minutes=%ltime:~3,1%*10+%ltime:~4,1%-%ftime:~3,1%*10-%ftime:~4,1%
set /a seconds=%ltime:~6,1%*10+%ltime:~7,1%-%ftime:~6,1%*10-%ftime:~7,1%
if %seconds% LSS 0 (
 set /a minutes=%minutes%-1
 set /a seconds=%seconds%+60
)
if %minutes% LSS 0 (
 set /a hours=%hours%-1
 set /a minutes=%minutes%+60
)
if %hours% LSS 0 (
 set /a hours=%hours%+24
)
set alltime=%hours%^:%minutes%^:%seconds%
echo It took: %alltime%
