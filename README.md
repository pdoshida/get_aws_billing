# get_aws_billing

# Usage
1. aws configure
2. cmd
```
./get_aws_billing.sh  | jq '.[] | .Timestamp, .Maximum '
```
