#!/bin/bash 

HOSTNAME="${COLLECTD_HOSTNAME:-localhost}"
INTERVAL="${COLLECTD_INTERVAL:-60}"

# Collectd Issues XY.000 as the interval so we cut everything after the dot
INTERVAL="${INTERVAL%.*}"

declare -A DATATYPES

DATATYPES=( 
  [total.num.queries]="derive" 
  [total.num.queries_ip_ratelimited]="derive" 
  [total.num.cachehits]="derive" 
  [total.num.cachemiss]="derive" 
  [total.num.prefetch]="derive" 
  [total.num.expired]="derive" 
  [total.num.recursivereplies]="derive" 
  [total.requestlist.avg]="gauge" 
  [total.requestlist.max]="derive" 
  [total.requestlist.overwritten]="derive" 
  [total.requestlist.exceeded]="derive" 
  [total.requestlist.current.all]="gauge" 
  [total.requestlist.current.user]="gauge" 
  [total.recursion.time.avg]="gauge" 
  [total.recursion.time.median]="gauge" 
  [total.tcpusage]="gauge" 
)


while sleep "${INTERVAL}"; do
    ALL_STATS=$(unbound-control stats_noreset)

    TIME=$(date +%s)    

    for STAT_LINE in $ALL_STATS 
    do  
        eval datatype=${DATATYPES[${STAT_LINE%=*}]}
        
        if [ -n "$datatype" ]; then
            echo "PUTVAL \"$HOSTNAME/unbound/$datatype-${STAT_LINE%=*}\" interval=${INTERVAL} $TIME:${STAT_LINE##*=}"
        fi
        
    done
done
