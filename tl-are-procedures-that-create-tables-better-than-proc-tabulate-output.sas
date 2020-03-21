Are procedures that create tables better than proc tabulate static output

Proc tabulate has a very serious bug, it does not honor ods output;

Create a percent by variable summary table

You get a output SAS table not just a static report

Github
https://tinyurl.com/sn2kw8d
https://github.com/rogerjdeangelis/utl-are-procedures-that-create-tables-better-than-proc-tabulate-output

SAS Forum
https://tinyurl.com/saap5gw
https://communities.sas.com/t5/SAS-Programming/creating-summary-table/m-p/633753


*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

DATA HAVE;
INPUT patientid afb cvd hf db;
datalines;
1 0 1 0 1
2 1 0 0 0
3 1 1 1 1
4 1 0 1 0
5 1 1 1 1
;;;;
run;

WORK.HAVE total obs=5

PATIENTID    AFB    CVD    HF    DB

    1         0      1      0     1
    2         1      0      0     0
    3         1      1      1     1
    4         1      0      1     0
    5         1      1      1     1

 *            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

* YOU GET A TABLE NOT STATIC OUTPUT;

WORK.WANT OBS=4

 VARIABLE    PERCENT

   AFB         80%
   CVD         60%
   HF          60%
   DB          60%


*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;

ods output summary=want(rename=mean=percent);
proc means data=have stackodsoutput mean;
var afb cvd hf db;
run;quit;

proc print data=want;
format percent percent6.1;
run;quit;

