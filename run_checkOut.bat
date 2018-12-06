rem @ECHO OFF
SET V_PROJECT=%1
SET V_RUL_CHCKOUT=%V_PROJECT%_rules_checkOut.txt
forfiles /M *.txt_ /C "cmd /c perl replace.pl @file DEV_@file %V_RUL_CHCKOUT%"