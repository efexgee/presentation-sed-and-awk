#/bin/bash

sed '
    1,4d;
    5s/job-ID /job-ID/;
    5,6s/^...//;
    7,$s/^....//;
    s/MASTER/MAIN  /;
    s/SLAVE/SUB  /' |
cut -c11-18 --complement
