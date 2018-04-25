#!/bin/bash

awk 'NR >=3 {
        jobs[$4]++;
        if ( $5 ~ /r/ ) {
            slots[$4] += $9
        } else {
            slots[$4] += $8 }
       }
       END {
        for ( user in jobs ) {
            printf "%-12s %6d %7d %3d\n", user, jobs[user], slots[user], slots[user] / jobs[user]
        }
       }' |
sort -nk3
