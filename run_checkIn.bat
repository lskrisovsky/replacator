@ECHO OFF
SET V_PROJECT=%1
SET V_RUL_CHCKIN=%V_PROJECT%_rules_checkIn.txt
forfiles /M DEV_*.txt_ /C "cmd /c perl replace.pl @file fin_@file %V_RUL_CHCKIN%"