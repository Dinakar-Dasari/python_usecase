#### Why we need to generate access token even though if we list only public repos
+ Ideally, we don’t need a token to list public repositories using the GitHub API.
+ But, GitHub allows around 60 unauthenticated requests per hour which is often insufficient for CI/CD tools, integrations, or web applications. But with a token, you can make up to 5,000 per hour
+ Because if we run the script in the pipeline or automate then it might do API calls multiple times.
+ Also, It allows access to private repos, if the token has the right permissions.
+ The **headers** carry metadata (auth info, content type, etc.)
+ we use `.env` file to store secrets and sensitive data like github tokens
  
---
#### parameters for describe_instances:
+ The parameters to filter the instances can be InstanceIds, Filters(list of filters to apply),etc
+ If no InstanceIds or Filters are specified, all instances are returned (which may be slow).
+ Each Filter dictionary must have a `"Name"` and a `"Values"` field.
  + ```
    Filters = [ { 'Name': 'tag:AutoStop', 'Values': ["true"] },
                { 'Name': "instance-state-name", "Values": ['running'] }  ]
    ```
  + Filter is a list of dictionaries
  + The `"Name"` is What you're filtering by (such as `"instance-type" `or `"tag:AutoStop"`)
  + `"Values"` is always a list even if it contains only one item. `["true"]`
  + **`tag:AutoStop`**: Look for instances that have a tag with the key `AutoStop`
  + **`['true']`**: Only match instances where the `AutoStop` tag value equals `'true'`
+ if there are multiple Values then it's an OR condition like Environment can be dev/test/staging
+ The response includes a Reservations list, where each reservation contains an Instances list with instance details.
---  
