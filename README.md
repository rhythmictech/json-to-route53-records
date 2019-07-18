# json to route53 records
tired of manually writing all those route53 records? 
wish you could slap them in a `json` file and call it a day?
want a way to export all your records into terraform?

## About 
Takes in a list of resource records,as `json`, with this schema: 
```
[
    {
        "data": list(string),   # contains the records
        "type": string,         # A | NS | SOA | etc...
        "name": string,         # contains the URL
        "ttl": number
    }
]
```

Turns each of these records into a `aws_route53_record` in terraform. 

## Usage 
See the [example](example)
