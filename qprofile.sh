#!/bin/bash

awk -v gigs_per_slot=2 '
    NR == 1 { next }
    /^Total System Usage/ { exit }
    /^jobnumber/ { job_id = $2 }
    /^jobname/ { job_name = $2 }
    /^maxrss/ { ram = $2 }
    /^cpu/ { cpu = $2 }
    /^wallclock/ { wall = $2 }
    /======/ {
        if ( ram ~ /M$/ ) { gigs = 0 }
        if ( ram ~ /G$/ ) { gigs = gensub(/G/,"",1,ram) };
        cores = cpu / wall;
        gig_slots = gigs / gigs_per_slot;
        if ( cores > gig_slots ) {
            slots = cores
        } else {
            slots = gig_slots
        }
        { printf "%s - %-56s : %3d Gb + %4.1f cores => %4.1f slots\n", job_id, job_name, gigs, cores, slots }
    }'
