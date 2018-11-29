#!/bin/bash
namespace=AWS/Billing
os_name=`uname`
now=`date -u "+%Y-%m-%dT%H:%M:%SZ"`
if [ $os_name = "Darwin" ]; then
    yesterday=`date -u -v-1d "+%Y-%m-%dT%H:%M:%SZ"`
else
    yesterday=`date -u -d "1 days ago" "+%Y-%m-%dT%H:%M:%SZ"`
fi
start_time=${1:-$yesterday}
end_time=${2:-$now}
period=300
metric=EstimatedCharges

aws cloudwatch get-metric-statistics \
    --region us-east-1 \
    --namespace $namespace \
    --metric-name $metric \
    --start-time $start_time \
    --end-time $end_time \
    --period $period \
    --statistics "Maximum" \
    --dimensions Name=Currency,Value=USD | jq '.Datapoints | sort_by(.Timestamp)'
