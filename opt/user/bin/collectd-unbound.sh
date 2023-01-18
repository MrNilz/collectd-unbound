#!/bin/sh 

HOSTNAME="${COLLECTD_HOSTNAME:-localhost}"
INTERVAL="${COLLECTD_INTERVAL:-60}"

# Collectd Issues XY.000 as the interval so we cut everything after the dot
INTERVAL="${INTERVAL%.*}"


# ASH does not support Arrays so we have to trick around a bit here
DATATYPE_17="derive" #<-- total.num.queries=22054
DATATYPE_18="derive" #<-- total.num.queries_ip_ratelimited=0
DATATYPE_19="derive" #<-- total.num.cachehits=8116
DATATYPE_20="derive" #<-- total.num.cachemiss=13938
DATATYPE_21="derive" #<-- total.num.prefetch=534
DATATYPE_22="derive" #<-- total.num.expired=0
DATATYPE_23="derive" #<-- total.num.recursivereplies=13938
DATATYPE_24="gauge"  #<-- total.requestlist.avg=1.22029
DATATYPE_25="derive" #<-- total.requestlist.max=25
DATATYPE_26="derive" #<-- total.requestlist.overwritten=0
DATATYPE_27="derive" #<-- total.requestlist.exceeded=0
DATATYPE_28="gauge"  #<-- total.requestlist.current.all=0
DATATYPE_29="gauge"  #<-- total.requestlist.current.user=0
DATATYPE_30="gauge"  #<-- total.recursion.time.avg=0.391448
DATATYPE_31="gauge"  #<-- total.recursion.time.median=0.0529392
DATATYPE_32="gauge"  #<-- total.tcpusage=0



while sleep "${INTERVAL}"; do
    ALL_STATS=$(unbound-control stats_noreset)

    TIME=$(date +%s)
    LINE_NUMBER=0

    for STAT_LINE in $ALL_STATS 
    do  
        LINE_NUMBER=$((LINE_NUMBER + 1))

        # we are only interested in the totals, so we skip the thread0 and time output
        if [[ $LINE_NUMBER -gt 16 && $LINE_NUMBER -lt 33 ]] ; then
        
          # Use LineNumber to get the correct Datatype from "ASH-Array"
          eval datatype="\$DATATYPE_$LINE_NUMBER"
          
          echo "PUTVAL \"$HOSTNAME/unbound/$datatype-${STAT_LINE%=*}\" interval=${INTERVAL} $TIME:${STAT_LINE##*=}"
        fi
        
        if [[ $LINE_NUMBER -gt 33 ]] ; then
          break
        fi
    done
done
